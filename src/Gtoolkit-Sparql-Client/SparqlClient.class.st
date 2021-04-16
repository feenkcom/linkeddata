"
SparqlClient uses a subset of the SPARQL 1.1 Graph Store HTTP Protocol to send and receive commands with the backend.

See:

- https://www.w3.org/TR/2013/REC-sparql11-http-rdf-update-20130321/
- https://www.w3.org/TR/sparql11-protocol/
"
Class {
	#name : #SparqlClient,
	#superclass : #Object,
	#instVars : [
		'datasetUrl'
	],
	#category : #'Gtoolkit-Sparql-Client'
}

{ #category : #accessing }
SparqlClient class >> datasetUrl: aUrl [

	^ self new datasetUrl: aUrl
]

{ #category : #accessing }
SparqlClient >> count [
	"Answer the total number of records in the supplied DB"

	^ self read: 'SELECT COUNT(?s) WHERE { ?s ?p ?o }'
]

{ #category : #accessing }
SparqlClient >> datasetUrl [
	^ datasetUrl
]

{ #category : #accessing }
SparqlClient >> datasetUrl: anObject [
	datasetUrl := anObject
]

{ #category : #querying }
SparqlClient >> evaluate: aString [
	"Send the supplied sparql string to be evaluated by the remote server"
	| fieldName entity response contentType |

	fieldName := self fieldNameFor: aString.
	fieldName = #query ifTrue: [ ^ self read: aString ].

	entity := ZnApplicationFormUrlEncodedEntity withAll: { 	fieldName -> aString } asDictionary.
	response := ZnEasy post: datasetUrl data: entity.
	contentType := response contentType.
	response isSuccess ifFalse:
		[ (self isPlainText: contentType) ifTrue: 
			[ self error: response contents ]
		ifFalse:
			[ self error: 'Unable to complete sparql query' ] ].
	(self isSparqlResult: contentType) ifTrue: 
		[ ^ STONJSON fromString: response contents ].
	(self isHTML: contentType) ifTrue: 
		[ ^ response contents ].
	self error: 'Unexpected result type: ', contentType asString
]

{ #category : #private }
SparqlClient >> fieldNameFor: aString [
	"Answer the form field name to be used for the supplied sparql command.
	This should parse the command and use the AST, but that doesn't exist yet..."
	| sparql update query |

	sparql := aString asLowercase.
	update := '(insert|delete)' asRegex search: sparql.
	query := 'select' asRegex search:sparql.
	"We can't do both in the same command"
	(update and: [ query ]) ifTrue: 
		[ self error: 'Unable to update and query in single command' ].
	(update or: [ query ]) ifFalse: 
		[ self error: 'Unrecognised sparql command' ].
	^ query
		ifTrue: [ #query ]
		ifFalse: [ #update ].
]

{ #category : #testing }
SparqlClient >> isHTML: aZnMimeType [

	^ aZnMimeType main = #text and: [ aZnMimeType sub = #html ]
]

{ #category : #testing }
SparqlClient >> isPlainText: aZnMimeType [

	^ aZnMimeType main = #plain and: [ aZnMimeType sub = #text ]
]

{ #category : #testing }
SparqlClient >> isSparqlResult: aZnMimeType [

	^ aZnMimeType main = #application and: [ aZnMimeType sub beginsWith: 'sparql-results+json' ]
]

{ #category : #querying }
SparqlClient >> read: aString [
	"Send the supplied sparql string to be evaluated by the remote server.
	The result is assumed to be a JSON encoded table."
	| response contentType |

	response := self send: aString type: #query.
	contentType := response contentType.
	(self isSparqlResult: contentType)ifFalse:
		[ self error: 'Unexpected result type: ', contentType asString ].
	^ SparqlQueryResult sourceString: response contents.

]

{ #category : #private }
SparqlClient >> send: aString type: type [
	"Send the supplied sparql string and type to the server for evaluation.
	Raise an exception of the response is a failure."
	| entity response contentType |

	entity := ZnApplicationFormUrlEncodedEntity withAll: { 	type -> aString } asDictionary.
	response := ZnEasy post: datasetUrl data: entity.
	contentType := response contentType.
	response isSuccess ifFalse:
		[ (self isPlainText: contentType) ifTrue: 
			[ self error: response contents ]
		ifFalse:
			[ self error: 'Unable to complete sparql query' ] ].
	^ response
]

{ #category : #querying }
SparqlClient >> triplesWithSubject: aRDFSubject [
	"Answer the receiver's triples that match aRDFSubject"
	| queryResult |

	queryResult := self read: (String streamContents: [ :stream |
		stream << 'SELECT ?p ?o WHERE { '.
		aRDFSubject printSparqlOn: stream.
		stream << ' ?p ?o. }' ]).
	^ queryResult value rowsCollect: [ :each |
		RDF tripleBuilder
			subject: aRDFSubject;
			predicate: each first;
			object: each second;
			build ]
]
