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
	^ sparqlClient evaluate: cmdString.
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

{ #category : #'as yet unclassified' }
RDFJenaStore >> gtPredicatesFor: aView [
	<gtView>

	(sparqlClient isNil or: [ sparqlClient count = 0 ]) ifTrue: [ ^ aView empty ].
	^ aView list 
		title: 'Predicates';
		priority: 10;
		items: [ (sparqlClient read: 'SELECT DISTINCT ?p WHERE { ?s ?p ?o. }') value asArray sorted:
			[ :a :b | a name < b name ] ]
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
	| queryResults bindings query predicate |

	query :=
'PREFIX poly: <http://polypoly.eu/schema/>

SELECT ?s ?o WHERE { ?s poly:sphere ?o }'.
	queryResults := sparqlClient evaluate: query.
	bindings := (queryResults at: #results) at: #bindings.
	predicate := RDF namedNode: 'http://polypoly.eu/schema/sphere'.
	^ bindings collect: [ :bindingDictionary |
		RDF tripleBuilder
			subjectJSONDictionary: (bindingDictionary at: #s);
			predicate: predicate;
			objectJSONDictionary: (bindingDictionary at: #o);
			build ]
]

{ #category : #accessing }
RDFJenaStore >> spheres [
	<return: #RDFSpheres>

	^ RDFSpheres new 
		store: self;
		collection: self polySphereTriples

]

{ #category : #enumerating }
RDFJenaStore >> triplesForSubject: aRDFSubject [
	<return: #RDFList>

	^ RDFList new collection: (sparqlClient triplesWithSubject: aRDFSubject)

]
