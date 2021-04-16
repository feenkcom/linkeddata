"
SparqlQueryResult holds the JSON encoded result of a SPARQL query in its source and provides convenient access to decoded values.

See https://www.w3.org/TR/sparql11-results-json/
"
Class {
	#name : #SparqlQueryResult,
	#superclass : #Object,
	#instVars : [
		'source',
		'isSingle',
		'value',
		'fieldNames'
	],
	#category : #'Gtoolkit-Sparql-Client'
}

{ #category : #accessing }
SparqlQueryResult class >> source: aDictionary [

	^ self new source: aDictionary
]

{ #category : #accessing }
SparqlQueryResult class >> sourceString: aString [

	^ self new source: (STONJSON fromString: aString)
]

{ #category : #accessing }
SparqlQueryResult >> bindings [ 
	"Answer the receiver's bindings"

	^ (source at: #results) at: #bindings
]

{ #category : #accessing }
SparqlQueryResult >> fieldNames [ 
	"Answer a collection of the receiver's field names"

	^ fieldNames ifNil: [ fieldNames := (source at: #head) at: #vars ]
]

{ #category : #private }
SparqlQueryResult >> getArrayValueFromSource [
	"Answer the Array2D value of the receiver"
	| result rowCount columnCount |

	rowCount := self bindings size.
	columnCount := self fieldNames size.
	result := Array2D rows: rowCount columns: columnCount.
	1 to: rowCount do: [ :row |
		1 to: columnCount do: [ :column |
			result at: row at: column put: 
				(RDFTerm fromJsonDictionary: ((self bindings at: row) at: (self fieldNames at: column))) ] ].
	^ result
]

{ #category : #private }
SparqlQueryResult >> getSingleValueFromSource [
	"Answer the single value of the receiver.
	This method assumes that only a single value is encoded"

	^ RDFTerm fromJsonDictionary: (self bindings first at: self fieldNames first)
]

{ #category : #private }
SparqlQueryResult >> getValueFromSource [
	"Answer the value encoded in the source.
	This will either be a single value or an Array2D of values (#isSingle indicates which)"

	^ self isSingle
		ifTrue: [ self getSingleValueFromSource ]
		ifFalse: [ self getArrayValueFromSource ]
]

{ #category : #'gt-extension' }
SparqlQueryResult >> gtLiveFor: aView [
	<gtView>
	| selector |

	source ifNil: [ ^ aView empty ].
	selector := self isSingle
		ifTrue: [ #gtValueFor: ]
		ifFalse: [ #gtItemsFor: ].
	^ aView forward 
		title: 'Value';
		priority: 10;
		object: [ self value ];
		view: selector.
]

{ #category : #testing }
SparqlQueryResult >> isSingle [ 
	"Answer a boolean indicating whether the receiver's result is a single value"

	^ isSingle ifNil: [ isSingle := self fieldNames size = 1 and: [ self bindings size = 1 ] ]
]

{ #category : #printing }
SparqlQueryResult >> printOn: aStream [

	super printOn: aStream.

	source ifNil: [ ^ self ].

	aStream << '('.
	self isSingle ifTrue: 
		[ aStream print: self value ]
	ifFalse:
		[ aStream
			print: self value columnCount;
			<< '@';
			print: self value rowCount ].
	aStream << ')'.
]

{ #category : #accessing }
SparqlQueryResult >> source [
	^ source
]

{ #category : #accessing }
SparqlQueryResult >> source: anObject [
	source := anObject
]

{ #category : #evaluating }
SparqlQueryResult >> value [ 

	^ value ifNil: [ value := self getValueFromSource ]
]
