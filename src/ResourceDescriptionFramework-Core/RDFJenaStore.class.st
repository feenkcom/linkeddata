"
Use Apache Jena as the back-end triple store.

- Tested against Apache Jena 4.0.
- Currently assumes credentials are not required.
"
Class {
	#name : #RDFJenaStore,
	#superclass : #RDFStore,
	#instVars : [
		'sparqlClient',
		'triples',
		'maxBufferSize',
		'telemetry'
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

	maxBufferSize = 0 ifTrue: [ ^ self saveTriple: aRDFTriple ].
	triples add: aRDFTriple.
	triples size >= maxBufferSize ifTrue: [ self flush ].
]

{ #category : #adding }
RDFJenaStore >> addTriples: aCollection [

	maxBufferSize = 0 ifTrue: [ ^ self saveTriples: aCollection ].
	triples addAll: aCollection.
	triples size >= maxBufferSize ifTrue: [ self flush ].
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

{ #category : #accessing }
RDFJenaStore >> flush [ 
	| newTriples oldTriples |

	triples ifEmpty: [ ^ self ].

	"Get the old triples as an atomic operation (assignments aren't interrupted)"
	newTriples := OrderedCollection new: (maxBufferSize * 1.5) rounded.
	oldTriples := triples.
	triples := newTriples.

	self saveTriples: oldTriples.

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

{ #category : #initialization }
RDFJenaStore >> initialize [ 

	super initialize.
	maxBufferSize := 0.
	triples := OrderedCollection new: (maxBufferSize * 1.5) rounded.
	telemetry := BlNullTelemetry new.
]

{ #category : #accessing }
RDFJenaStore >> maxBufferSize [
	^ maxBufferSize
]

{ #category : #accessing }
RDFJenaStore >> maxBufferSize: anObject [
	maxBufferSize := anObject
]

{ #category : #private }
RDFJenaStore >> saveTriple: aRDFTriple [
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

{ #category : #private }
RDFJenaStore >> saveTriples: aCollection [
	| cmdString |

	aCollection ifEmpty: [ ^ self ].
	
	self telemetry
		timeSync: [ 'Build insert query string' ]
		during: [ 
			cmdString := String new: 2000000 streamContents: [ :stream |
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
				 ] ].
		
	^ self telemetry
		timeSync: [ 'Perform insert query of size ', cmdString size asString ]
		during: [ 
			sparqlClient update: cmdString. ] 
]

{ #category : #accessing }
RDFJenaStore >> sparqlClient [

	^ sparqlClient
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

{ #category : #accessing }
RDFJenaStore >> telemetry [
	^ telemetry
]

{ #category : #accessing }
RDFJenaStore >> telemetry: anObject [
	telemetry := anObject
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
