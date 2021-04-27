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
	#category : #'Sparql-Client'
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
SparqlQueryResult >> at: rowNumber at: columnNumber [

	self assert: self isSingle not.
	^ self value at: rowNumber at: columnNumber
]

{ #category : #accessing }
SparqlQueryResult >> bindings [ 
	"Answer the receiver's bindings"

	^ (source at: #results) at: #bindings
]

{ #category : #enumerating }
SparqlQueryResult >> do: aBlock [ 
	"Evaluate a block for each of the records in the receiver"

	self isSingle
		ifTrue: [ aBlock value: self value ]
		ifFalse: [ self value rowsDo: aBlock ]
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
				(RDFTerm fromJsonDictionary: ((self bindings at: row) at: (self fieldNames at: column) ifAbsent: [ nil ])) ] ].
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

{ #category : #'gt-inspector-extension' }
SparqlQueryResult >> gtTableFor: aView [
	<gtView>

	(fieldNames isNil or: 
	[ self isSingle or: 
	[ self value numberOfRows isZero or: 
	[ self value numberOfColumns isZero ] ] ]) 
		ifTrue: [ ^ aView empty ].
	^ aView forward
		title: 'Table';
		priority: 10;
		object: [ self value ];
		view: #gtTableFor:
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

{ #category : #querying }
SparqlQueryResult >> triplesWithObject: aRDFObject [
	"Answer a collection of triples based on the receiver holding the subject and object and using the supplied object.
	Assumes names: predicate = p and object = o"

	self assert: fieldNames size equals: 2.
	self assert: fieldNames second equals: #s.
	self assert: fieldNames first equals: #p.

	^ self value rowsCollect: [ :each |
		RDF tripleBuilder
			subject: (RDFSubject term: each first);
			predicate: (RDFPredicate term: each second);
			object: aRDFObject;
			build ]
]

{ #category : #querying }
SparqlQueryResult >> triplesWithPredicate: aRDFPredicate [
	"Answer a collection of triples based on the receiver holding the subject and object and using the supplied predicate.
	Assumes names: subject = s and object = o"

	self assert: self fieldNames size equals: 2.
	self assert: self fieldNames first equals: #s.
	self assert: self fieldNames second equals: #o.

	^ self value rowsCollect: [ :each |
		RDF tripleBuilder
			subject: (RDFSubject term: each first);
			predicate: aRDFPredicate;
			object: (RDFObject term: each second);
			build ]
]

{ #category : #querying }
SparqlQueryResult >> triplesWithSubject: aRDFSubject [
	"Answer a collection of triples based on the receiver holding the subject and object and using the supplied subject.
	Assumes names: predicate = p and object = o"

	self assert: self fieldNames size equals: 2.
	self assert: self fieldNames first equals: #p.
	self assert: self fieldNames second equals: #o.

	^ self value rowsCollect: [ :each |
		RDF tripleBuilder
			subject: aRDFSubject;
			predicate: (RDFPredicate term: each first);
			object: (RDFObject term: each second);
			build ]
]

{ #category : #evaluating }
SparqlQueryResult >> value [ 

	^ value ifNil: [ value := self getValueFromSource ]
]
