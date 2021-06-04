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
	#category : #'Sparql-Client'
}

{ #category : #accessing }
SparqlClient class >> datasetUrl: aUrl [

	^ self new datasetUrl: aUrl
]

{ #category : #private }
SparqlClient >> checkPostException: anException [
	| sender string |

	anException messageText = 'Incomplete input for character decoding' ifFalse:
		[ ^ anException pass ].

	sender := anException signalerContext sender.
	[ sender isNotNil and: [ sender method selector ~= #readInto:startingAt:count:fromStream: ] ] whileTrue:
		[ sender := sender sender ].
	sender ifNil: [ ^ anException pass ].
	string := sender tempNamed: #string.
	(string includesSubstring: #succeeded) ifTrue: [ 
		"The string looks OK, simulate a response"
		^ (ZnResponse statusCode: 200)
			headers: ZnHeaders defaultResponseHeaders;
			entity: (ZnStringEntity html: (string copyFrom: 1 to: (string indexOf: Character null)-1)) ].
	^ anException pass
]

{ #category : #private }
SparqlClient >> checkReadException: anException [
	| sender string response |

	anException messageText = 'Incomplete input for character decoding' ifFalse:
		[ ^ anException pass ].

	sender := anException signalerContext sender.
	[ sender isNotNil and: [ sender method selector ~= #readInto:startingAt:count:fromStream: ] ] whileTrue:
		[ sender := sender sender ].
	sender ifNil: [ ^ anException pass ].
	string := sender tempNamed: #string.
	(string includesSubstring: #head) ifTrue: [ 
		"The string looks OK, simulate a response"
		response := (ZnResponse statusCode: 200)
			headers: ZnHeaders defaultResponseHeaders;
			entity: (ZnStringEntity json: (string copyFrom: 1 to: (string indexOf: Character null)-1)).
		response headers contentType: 'application/sparql-results+json'.
		response entity contentType: 'application/sparql-results+json'.
		^ response ].
	^ anException pass
]

{ #category : #querying }
SparqlClient >> construct: aString [
	"Send the supplied sparql CONSTRUCT string to be evaluated by the remote server.
	The result is assumed to be a TURTLE encoded graph."
	| response contentType query accept |

	query := datasetUrl asZnUrl copy.
	query queryAt: #query add: aString.
	accept := ZnMimeType main: 'text' sub: 'turtle'.
	response := ZnClient new
		beOneShot;
		url: query;
		accept: accept;
		timeout: 240;
		get;
		response.
	contentType := response contentType.
	response isSuccess ifFalse:
		[ (self isPlainText: contentType) ifTrue: 
			[ self error: response contents ]
		ifFalse:
			[ self error: 'Unable to complete sparql query' ] ].
	(self isTurtleResult: contentType)ifFalse:
		[ self error: 'Unexpected result type: ', contentType asString ].
	^ RDFTurtleTripleVisitor parse: response contents.

]

{ #category : #accessing }
SparqlClient >> count [
	"Answer the total number of records in the supplied DB"

	^ (self read: 'SELECT COUNT(?s) WHERE { ?s ?p ?o }') value value
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
	| fieldName |

	fieldName := self fieldNameFor: aString.
	fieldName = #query ifTrue: [ ^ self read: aString ].
	fieldName = #construct ifTrue: [ ^ self construct: aString ].
	^ self update: aString.

]

{ #category : #private }
SparqlClient >> fieldNameFor: aString [
	"Answer the form field name to be used for the supplied sparql command.
	This should parse the command and use the AST, but that doesn't exist yet...
	Use the first match instead (which will get it wrong sometimes"
	| sparql |

	sparql := aString asLowercase.
	('select' asRegex search: sparql) ifTrue: [ ^ #query ].
	('construct' asRegex search: sparql) ifTrue: [ ^ #construct ].
	('(insert|delete)' asRegex search: sparql) ifTrue: [ ^ #update ].
	self error: 'Unrecognised command'.

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

{ #category : #testing }
SparqlClient >> isTurtleResult: aZnMimeType [

	^ aZnMimeType main = #text and: [ aZnMimeType sub = #turtle ]
]

{ #category : #private }
SparqlClient >> post: znEntity [
	"Post the supplied Zn entity and catch spurious errors triggered by Jena's encoding.
	Zinc will raise an 'Incomplete input for character decoding' exception when in fact the entire response appears to be present.  It looks like the issue is that Jena is providing the content length, which Zinc doesn't handle well."

	^ [ ZnEasy post: datasetUrl data: znEntity ]
		on: Error
		do: [ :ex | self checkPostException: ex ]
]

{ #category : #private }
SparqlClient >> post: aString type: type [
	"Send the supplied sparql string and type to the server for evaluation.
	Raise an exception of the response is a failure."
	| entity response contentType accept |

	entity := ZnApplicationFormUrlEncodedEntity withAll: { 	type -> aString } asDictionary.
	accept := ZnMimeType main: 'application' sub: 'sparql-results+json'.
	response := ZnClient new
		beOneShot;
		url: datasetUrl;
		entity: entity;
		accept: accept;
		post;
		response.
	contentType := response contentType.
	response isSuccess ifFalse:
		[ (self isPlainText: contentType) ifTrue: 
			[ self error: response contents ]
		ifFalse:
			[ self error: 'Unable to complete sparql query' ] ].
	^ response
]

{ #category : #printing }
SparqlClient >> printOn: aStream [

	datasetUrl ifNil: [ ^ super printOn: aStream ].
	aStream
		<< 'Sparql @ ';
		<< datasetUrl
]

{ #category : #querying }
SparqlClient >> read: aString [
	"Send the supplied sparql string to be evaluated by the remote server.
	The result is assumed to be a JSON encoded table."
	| client response contentType query accept |

	query := datasetUrl asZnUrl copy.
	query queryAt: #query add: aString.
	accept := ZnMimeType main: 'application' sub: 'sparql-results+json'.
	client := ZnClient new
		beOneShot;
		url: query;
		accept: accept;
		timeout: 240.
	response := [ client get; response ]
		on: Error
		do: [ :ex | self checkReadException: ex ].
	contentType := response contentType.
	response isSuccess ifFalse:
		[ (self isPlainText: contentType) ifTrue: 
			[ self error: response contents ]
		ifFalse:
			[ self error: 'Unable to complete sparql query' ] ].
	(self isSparqlResult: contentType)ifFalse:
		[ self error: 'Unexpected result type: ', contentType asString ].
	^ SparqlQueryResult sourceString: response contents.

]

{ #category : #updating }
SparqlClient >> update: aString [
	"Send the supplied sparql update string (e.g. INSERT) to be evaluated by the remote server"
	| entity response contentType |

	entity := ZnApplicationFormUrlEncodedEntity withAll: { #update -> aString } asDictionary.
	response := self post: entity.
	contentType := response contentType.
	response isSuccess ifFalse:
		[ (self isPlainText: contentType) ifTrue: 
			[ self error: response contents ]
		ifFalse:
			[ self error: 'Unable to complete sparql query' ] ].
	(self isSparqlResult: contentType) ifTrue: 
		[ ^ self error: 'Update expected HTML response' ].
	(self isHTML: contentType) ifTrue: 
		[ (response contents includesSubstring: 'succeeded') ifFalse:
			[ self error: 'Unexpected response: ', response contents ].
		^ self ].
	self error: 'Unexpected result type: ', contentType asString
]
