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
		'maxBufferSize',
		'telemetry',
		'writeTriples',
		'writeStrings',
		'prefixes'
	],
	#category : #'ResourceDescriptionFramework-Core-Storage'
}

{ #category : #'instance creation' }
RDFJenaStore class >> datasetUrl: aURL [

	^ self new datasetUrl: aURL
]

{ #category : #accessing }
RDFJenaStore >> addPrefix: prefixName iri: aString [ 
	"Add the supplied prefix, ensuring that it matches an existing definition"
	| iri newIri |

	newIri := '<', aString, '>'.
	iri := prefixes at: prefixName ifAbsentPut: [ newIri ].
	newIri = iri ifFalse: [ self error: 'Prefix definition contradicts existing definition' ].
]

{ #category : #adding }
RDFJenaStore >> addTriple: aRDFTriple [

	maxBufferSize = 0 ifTrue: [ ^ self flushTriples: { aRDFTriple } ].
	writeTriples add: aRDFTriple.
	writeTriples size >= maxBufferSize ifTrue: [ self flush ].
]

{ #category : #adding }
RDFJenaStore >> addTriples: aCollection [

	maxBufferSize = 0 ifTrue: [ ^ self flushTriples: aCollection ].
	writeTriples addAll: aCollection.
	writeTriples size >= maxBufferSize ifTrue: [ self flush ].
]

{ #category : #'querying - sparql' }
RDFJenaStore >> construct: aString [
	"Add known prefixes and evaluate the supplied string"
	| queryString |

	queryString := String streamContents: [ :stream |
		self printNamespacesOn: stream.
		stream << aString ].
	^ sparqlClient construct: queryString
]

{ #category : #'querying - sparql' }
RDFJenaStore >> constructWhere: aString [
	"Add known prefixes and evaluate the supplied string"
	| queryString |

	queryString := String streamContents: [ :stream |
		self printNamespacesOn: stream.
		stream 
			cr;
			<< 'CONSTRUCT WHERE { ';
			<< aString;
			<< ' }' ].
	^ sparqlClient construct: queryString
]

{ #category : #accessing }
RDFJenaStore >> count [

	^ sparqlClient count
]

{ #category : #accessing }
RDFJenaStore >> datasetUrl [
	^ sparqlClient datasetUrl
]

{ #category : #accessing }
RDFJenaStore >> datasetUrl: aUrl [
	"Specify the URL of the back-end triple store.
	E.g. 'http://localhost:3030/mydataset' asZnURL"

	sparqlClient := SparqlClient datasetUrl: aUrl
]

{ #category : #querying }
RDFJenaStore >> deleteWithSubject: aRdfSubject [
	"Delete all the receiver's triples with the supplied subject"

	self tsUpdate: (String streamContents: [ :stream |
		stream << 'DELETE { '.
		aRdfSubject printSparqlOn: stream.
		stream << ' ?p ?o } WHERE { '.
		aRdfSubject printSparqlOn: stream.
		stream << ' ?p ?o }' ])

]

{ #category : #querying }
RDFJenaStore >> deleteWithSubjectIRI: aString [
	"Delete all the receiver's triples with the supplied subject"

	self deleteWithSubject: (RDFTripleBuilder new subjectIRI: aString)
]

{ #category : #'querying - sparql' }
RDFJenaStore >> evaluate: aString [
	"Add known prefixes and evaluate the supplied string"
	| queryString |

	queryString := String streamContents: [ :stream |
		self printNamespacesOn: stream.
		stream << aString ].
	^ sparqlClient evaluate: queryString
]

{ #category : #adding }
RDFJenaStore >> flush [ 

	writeTriples ifNotEmpty:
		[ self flushTriples: writeTriples.
		writeTriples := OrderedCollection new: maxBufferSize ].
	writeStrings ifNotEmpty:
		[ self flushStrings: writeStrings.
		writeStrings := OrderedCollection new: maxBufferSize ].
]

{ #category : #private }
RDFJenaStore >> flushStrings: aCollection [
	"Write the supplied collection of sparql commands to the DB"

	sparqlClient update: (String streamContents: [ :stream |
		prefixes keysAndValuesDo: [ :key : value |
			stream
				<< 'prefix ';
				<< key;
				<< ': ';
				<< value;
				cr ].
		stream cr.
		aCollection
			do: [ :each | stream << each ]
			separatedBy: [ stream << ';'; cr ] ]).
]

{ #category : #private }
RDFJenaStore >> flushTriples: aCollection [
	| cmdString |

	aCollection ifEmpty: [ ^ self ].
	self telemetry
		timeSync: [ 'Build insert query string' ]
		during: [ 
			cmdString := String new: 2000000 streamContents: [ :stream |
				prefixes keysAndValuesDo: [ :key : value |
					stream
						<< 'prefix ';
						<< key;
						<< ': ';
						<< value;
						cr ].
					stream cr.

				aCollection do: [ :aRDFTriple |
					stream << 'INSERT { '.
					aRDFTriple subject term printSparqlOn: stream.
					stream << ' '.
					aRDFTriple predicate term printSparqlOn: stream.
					stream << ' '.
					aRDFTriple object term printSparqlOn: stream.
					stream << ' } WHERE {};'; cr ] ] ].
		
	^ self telemetry
		timeSync: [ 'Perform insert query of size ', cmdString size asString ]
		during: [ 
			sparqlClient update: cmdString. ] 
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
		send: [ :item | self triplesWithPredicate: (RDFPredicate new term: item) ]
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
	writeTriples := OrderedCollection new: (maxBufferSize * 1.5) rounded.
	writeStrings := OrderedCollection new: maxBufferSize.
	telemetry := BlNullTelemetry new.
	prefixes := Dictionary new.
]

{ #category : #accessing }
RDFJenaStore >> maxBufferSize [
	^ maxBufferSize
]

{ #category : #accessing }
RDFJenaStore >> maxBufferSize: anObject [
	maxBufferSize := anObject
]

{ #category : #'querying - values' }
RDFJenaStore >> objectValuesWithSubject: aRDFSubject predicate: aRdfPredicate [
	<return: #Collection of: #RDFLiteral>
	| queryResult |

	queryResult := self read: (String streamContents: [ :stream |
		stream << 'SELECT ?o WHERE { '.
		aRDFSubject printSparqlOn: stream.
		stream space.
		aRdfPredicate printSparqlOn: stream.
		stream << ' ?o. }' ]).
	^ queryResult value 
		ifEmpty: [ #() ]
		ifNotEmpty: [ :array | array atColumn: 1 ].
]

{ #category : #printing }
RDFJenaStore >> printNamespacesOn: aStream [
	"Print all the known namespaces on aStream.
	This includes locally specified namespaces and those in RdfResources."

	RdfResources uniqueInstance printNamespacesOn: aStream.
	prefixes keysAndValuesDo: [ :key : value |
		aStream
			<< 'prefix ';
			<< key;
			<< ': ';
			<< value;
			cr ].

]

{ #category : #printing }
RDFJenaStore >> printOn: aStream [

	aStream << 'RDF store: '.
	sparqlClient ifNil: [ ^ self ].
	aStream << sparqlClient datasetUrl
]

{ #category : #'querying - sparql' }
RDFJenaStore >> read: aString [
	"Add known prefixes and evaluate the supplied string"
	| queryString |

	queryString := String streamContents: [ :stream |
		self printNamespacesOn: stream.
		stream << aString ].
	^ sparqlClient read: queryString
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

{ #category : #'querying - values' }
RDFJenaStore >> subjectValuesWithPredicate: aRdfPredicate object: aRdfObject [
	<return: #Collection of: #RDFLiteral>
	| queryResult |

	queryResult := self read: (String streamContents: [ :stream |
		stream << 'SELECT ?s WHERE { ?s '.
		aRdfPredicate printSparqlOn: stream.
		stream space.
		aRdfObject printSparqlOn: stream.
		stream << ' }' ]).
	^ queryResult value 
		ifEmpty: [ #() ]
		ifNotEmpty: [ :array | array atColumn: 1 ].
]

{ #category : #'querying - values' }
RDFJenaStore >> subjectValuesWithPredicate: aRdfPredicate objectValue: anObject [
	<return: #Collection of: #RDFLiteral>

	^ self 
		subjectValuesWithPredicate: aRdfPredicate 
		object: (RDFTripleBuilder new objectValue: anObject)
]

{ #category : #accessing }
RDFJenaStore >> telemetry [
	^ telemetry
]

{ #category : #accessing }
RDFJenaStore >> telemetry: anObject [
	telemetry := anObject
]

{ #category : #'querying - triples' }
RDFJenaStore >> triplesWhere: aString [ 
	"Answer the collection of triples that match the supplied criteria.
	No security checks are made."
	| constructQuery |

	constructQuery := String streamContents: [ :stream |
		stream 
			<< 'CONSTRUCT WHERE { ';
			<< aString;
			<< ' }' ].
	^ self construct: constructQuery.
]

{ #category : #'querying - triples' }
RDFJenaStore >> triplesWithObject: aRDFObject [
	"Answer the receiver's triples that match aRDFObject"
	<return: #RDFList>
	| queryResult |

	queryResult := self read: (String streamContents: [ :stream |
		stream << 'SELECT ?s ?p WHERE { ?s ?p '.
		aRDFObject printSparqlOn: stream.
		stream << ' }' ]).
	^ queryResult triplesWithObject: aRDFObject
]

{ #category : #'querying - triples' }
RDFJenaStore >> triplesWithPredicate: aRdfPredicate [
	<return: #RDFList>
	| queryResult |

	queryResult := self read: (String streamContents: [ :stream |
		stream << 'SELECT ?s ?o WHERE { ?s '.
		aRdfPredicate printSparqlOn: stream.
		stream << ' ?o. }' ]).
	^ RDFList new collection: (queryResult triplesWithPredicate: aRdfPredicate)

]

{ #category : #'querying - triples' }
RDFJenaStore >> triplesWithSubject: aRDFSubject [
	"Answer the receiver's triples that match aRDFSubject"
	<return: #RDFList>
	| queryResult |

	queryResult := self read: (String streamContents: [ :stream |
		stream << 'SELECT ?p ?o WHERE { '.
		aRDFSubject printSparqlOn: stream.
		stream << ' ?p ?o. }' ]).
	^ RDFList new collection: (queryResult triplesWithSubject: aRDFSubject)

]

{ #category : #'querying - triples' }
RDFJenaStore >> triplesWithSubject: aRDFSubject predicate: aRdfPredicate [
	"Answer the receiver's triples that match aRDFSubject"
	<return: #RDFList>
	| queryResult |

	queryResult := self read: (String streamContents: [ :stream |
		stream << 'SELECT ?o WHERE { '.
		aRDFSubject printSparqlOn: stream.
		stream space.
		aRdfPredicate printSparqlOn: stream.
		stream << ' ?o. }' ]).
	^ RDFList new collection: (queryResult triplesWithSubject: aRDFSubject predicate: aRdfPredicate)

]

{ #category : #adding }
RDFJenaStore >> tsAddTriple: aRdfTriple [

	self tsAddTriples: { aRdfTriple }
]

{ #category : #adding }
RDFJenaStore >> tsAddTriples: aCollection [
	| oldTriples newTriples |

	dbMutex critical: 
		[ writeTriples addAll: aCollection.
		writeTriples size < maxBufferSize ifTrue: [ ^ self ].
		newTriples := OrderedCollection new: maxBufferSize.
		oldTriples := writeStrings.
		writeStrings := newTriples ].
	self flushTriples: oldTriples.

]

{ #category : #'querying - sparql' }
RDFJenaStore >> tsUpdate: aString [ 
	| oldStrings newStrings queryString |

	queryString := String streamContents: [ :stream |
		self printNamespacesOn: stream.
		stream cr; << aString ].

	dbMutex critical: [ writeStrings add: queryString.
		writeStrings size < maxBufferSize ifTrue: [ ^ self ].
		newStrings := OrderedCollection new: maxBufferSize.
		oldStrings := writeStrings.
		writeStrings := newStrings ].
	self flushStrings: oldStrings.

]

{ #category : #'querying - convenience' }
RDFJenaStore >> uniqueSubjects [
	"Answer all the unique subjects in the database.
	Mainly for testing in small datbaases."

	^ self read: 'SELECT DISTINCT ?s WHERE { ?s ?p ?o }'
]

{ #category : #'querying - sparql' }
RDFJenaStore >> update: aString [
	"This shouldn't really be here, there should be a higher level api, but it's useful for now"
	| queryString |

	queryString := String streamContents: [ :stream |
		self printNamespacesOn: stream.
		stream cr; << aString ].
	maxBufferSize = 0 ifTrue: [ ^ self flushStrings: { queryString } ].
	writeStrings add: queryString.
	writeStrings size < maxBufferSize ifTrue: [ ^ self ].
	self flushStrings: writeStrings.
	writeStrings := OrderedCollection new: maxBufferSize.
]
