"
Use Apache Jena as the back-end triple store.

- Tested against Apache Jena 4.0.
- Currently assumes credentials are not required.
"
Class {
	#name : #RDFJenaStore,
	#superclass : #RDFStore,
	#instVars : [
		'sparqlClient'
	],
	#category : #'ResourceDescriptionFramework-Core-Storage'
}

{ #category : #'instance creation' }
RDFJenaStore class >> datasetURL: aURL [

	^ self new datasetURL: aURL
]

{ #category : #adding }
RDFJenaStore >> addKnownPrefixesTo: stream [
	"Add the known prefix definitions to the supplied stream.
	Subclasses of RDFTermFactory are considered known."
	| factory |

	RDFTermFactory subclassesDo: [ :cls |
		factory := cls new.
		stream 
			<< 'PREFIX ';
			<< factory shortName;
			<< ': <';
			<< factory prefix;
			<< '>';
			cr ].
]

{ #category : #adding }
RDFJenaStore >> addTriple: aRDFTriple [
	| cmdString |

	aRDFTriple ifNil: [ ^ self ].
	cmdString := String streamContents: [ :stream |
		self addKnownPrefixesTo: stream.
		stream cr.
		stream << 'INSERT { '.
		aRDFTriple subject term printSparqlOn: stream.
		stream << ' '.
		aRDFTriple predicate term printSparqlOn: stream.
		stream << ' '.
		aRDFTriple object term printSparqlOn: stream.
		stream << ' } WHERE {}'
		 ].
	^ sparqlClient update: cmdString.
]

{ #category : #adding }
RDFJenaStore >> addTriples: aCollection [
	| cmdString |

	aCollection ifEmpty: [ ^ self ].
	cmdString := String streamContents: [ :stream |
		self addKnownPrefixesTo: stream.
		stream cr.
		aCollection do: [ :aRDFTriple |
			stream << 'INSERT { '.
			aRDFTriple subject term printSparqlOn: stream.
			stream << ' '.
			aRDFTriple predicate term printSparqlOn: stream.
			stream << ' '.
			aRDFTriple object term printSparqlOn: stream.
			stream << ' } WHERE {};'; cr ].
		 ].
	^ sparqlClient update: cmdString.
]

{ #category : #accessing }
RDFJenaStore >> datasetURL [
	^ sparqlClient datasetURL
]

{ #category : #accessing }
RDFJenaStore >> datasetURL: aUrl [
	"Specify the URL of the back-end triple store.
	E.g. 'http://localhost:3030/mydataset' asZnURL"

	sparqlClient := SparqlClient datasetUrl: aUrl
]

{ #category : #'as yet unclassified' }
RDFJenaStore >> gtListSpheresFor: aView [
	<gtView>

	(sparqlClient isNil or: [ sparqlClient count = 0 ]) ifTrue: [ ^ aView empty ].
	^ aView list
		title: 'Sphere types';
		priority: 1;
		items: [ RDFUniqueSphere allSubclasses collect: [ :eachClass | eachClass ] ];
		itemText: #sphereName;
		send: [ :sphereClass | 
			| sphereTypeTriples |
			sphereTypeTriples := self spheres collection
				select: [ :aSphereTriple | aSphereTriple object term value = sphereClass sphereName ].
			RDFSphereResourcesGroup withAll:
				(sphereTypeTriples collect: [ :aSphereTypeTriple | 
					self
						resourceForSubject: aSphereTypeTriple subject
						withSphere: (RDFSphere ofName: aSphereTypeTriple object term value) ]) ]
]

{ #category : #ui }
RDFJenaStore >> gtPredicatesFor: aView [
	<gtView>

	(sparqlClient isNil or: [ sparqlClient count = 0 ]) ifTrue: [ ^ aView empty ].
	^ aView list 
		title: 'Predicates';
		priority: 10;
		items: [ (sparqlClient read: 'SELECT DISTINCT ?p WHERE { ?s ?p ?o. }') value asArray sorted:
			[ :a :b | a name < b name ] ];
		send: [ :item | self triplesForPredicate: (RDFPredicate new term: item) ]
]

{ #category : #ui }
RDFJenaStore >> gtStatusFor: aView [
	<gtView>

	sparqlClient ifNil: [ ^ aView empty ].
	^ aView textEditor 
		title: 'Status';
		priority: 50;
		text: [ self statusString asRopedText glamorousCodeFont ]
]

{ #category : #'gt-extension' }
RDFJenaStore >> gtTripleSpheresFor: aView [
	<gtView>
	
	(sparqlClient isNil or: [ sparqlClient count = 0 ]) ifTrue: [ ^ aView empty ].
	^ aView forward
		title: 'Triples (spheres)';
		priority: 1;
		object: [ self spheres ];
		view: #gtTripleSpheresFor:
]

{ #category : #'as yet unclassified' }
RDFJenaStore >> polySphereTriples [
	| queryResults |

	queryResults := sparqlClient read:
'PREFIX poly: <http://polypoly.eu/schema/>

SELECT ?s ?o WHERE { ?s poly:sphere ?o }'.
	^ queryResults triplesWithPredicate: POLY sphere.
]

{ #category : #accessing }
RDFJenaStore >> spheres [
	<return: #RDFSpheres>

	^ RDFSpheres new 
		store: self;
		collection: self polySphereTriples

]

{ #category : #ui }
RDFJenaStore >> statusString [ 

	sparqlClient ifNil: [ ^ '<no client>' ].
	^ String streamContents: [ :stream |
		stream 
			<< 'Dataset:      ';
				print: sparqlClient datasetUrl; cr;
			<< 'Triple count: ';
				print: sparqlClient count; cr ].
]

{ #category : #enumerating }
RDFJenaStore >> triplesForObject: aRDFObject [
	<return: #RDFList>

	^ RDFList new collection: (sparqlClient triplesWithObject: aRDFObject)

]

{ #category : #enumerating }
RDFJenaStore >> triplesForPredicate: aRDFPredicate [
	<return: #RDFList>

	^ RDFList new collection: (sparqlClient triplesWithPredicate: aRDFPredicate)

]

{ #category : #enumerating }
RDFJenaStore >> triplesForSubject: aRDFSubject [
	<return: #RDFList>

	^ RDFList new collection: (sparqlClient triplesWithSubject: aRDFSubject)

]

{ #category : #enumerating }
RDFJenaStore >> triplesForSubject: aRDFSubject forSphere: aRDFSphere [
	<return: #RDFList>
	| queryResult predicateNames term |

	predicateNames := aRDFSphere relevantPredicates collect: #shortName.
	queryResult := sparqlClient read: (String streamContents: [ :stream |
		stream << 'SELECT '.
		predicateNames 
			do: [ :name | 
				stream 
					nextPut: $?;
					<< name ]
			separatedBy: [ stream space ].
		stream << ' WHERE { '; cr.
		aRDFSphere relevantPredicates do: [ :predicate |
			stream << 'OPTIONAL {'.
			aRDFSubject printSparqlOn: stream.
			stream space.
			predicate printSparqlOn: stream.
			stream
				<< ' ?';
				<< predicate shortName;
				<< ' }';
				cr ].
		stream << '}' ] ).
	^ RDFList new collection: ((aRDFSphere relevantPredicates collectWithIndex: [ :predicate :index |
		term := queryResult at: 1 at: index.
		term ifNotNil:
			[ RDF tripleBuilder
				subject: aRDFSubject;
				predicate: predicate;
				object: (RDFObject term: term);
				build ] ] ) select: #isNotNil )

]
