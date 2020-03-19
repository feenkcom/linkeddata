Class {
	#name : #RDFLiteral,
	#superclass : #RDFTerm,
	#instVars : [
		'language',
		'dataType'
	],
	#category : #'ResourceDescriptionFramework-Core-Model'
}

{ #category : #convenient }
RDFLiteral >> boolean: aBoolean [
	self 
		assert: [ aBoolean isString ] 
		description: [ 'Literal value must be a string' ].
	self dataType: XSD boolean.
	self value: aBoolean.
]

{ #category : #accessing }
RDFLiteral >> dataType [
	"Return a value whose IRI represents the datatype of the literal"
	<return: #RDFNamedNode>
	^ dataType
]

{ #category : #accessing }
RDFLiteral >> dataType: anObject [
	dataType := anObject
]

{ #category : #accessing }
RDFLiteral >> description [
	^ String streamContents: [ :aStream |
		self value ifNil: [ ^ super description ].
		aStream nextPutAll: self dataType asString.
		aStream nextPutAll: ' '.
		aStream nextPutAll: self value asString.
		self language ifNotNil: [ 
			aStream nextPut: $@; print: self language ] ]
]

{ #category : #comparing }
RDFLiteral >> equals: aRDFTerm [
	^ (super equals: aRDFTerm) and: [ 
		self dataType = aRDFTerm dataType and: [ 
			self language = aRDFTerm language ] ]
]

{ #category : #'gt-extension' }
RDFLiteral >> gtValueFor: aView [
	<gtView>
	self value ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Value';
		items: [ { 'Value' -> self value. 'Language' -> self language. 'Data type' -> self dataType } ];
		column: 'Description' item: [ :anAssoc | anAssoc key ] width: 80;
		column: 'Value' item: [ :anAssoc | anAssoc value ];
		send: [ :anAssoc | anAssoc value ]
]

{ #category : #accessing }
RDFLiteral >> language [
	<return: #RDFLanguage>
	^ language
]

{ #category : #accessing }
RDFLiteral >> language: anObject [
	language := anObject
]

{ #category : #printing }
RDFLiteral >> printOn: aStream [
	self value ifNil: [ ^ super printOn: aStream ].
	aStream nextPutAll: self value asString.
	self language ifNil: [ ^ self ].
	aStream nextPut: $@; print: self language. 
]

{ #category : #printing }
RDFLiteral >> printShortOn: aStream [
	self value ifNil: [ ^ self printOn: aStream ].
	aStream nextPutAll: self value asString.
]

{ #category : #convenient }
RDFLiteral >> string: aString [
	self 
		assert: [ aString isString ] 
		description: [ 'Literal value must be a string' ].
	self dataType: XSD string.
	self value: aString.
]

{ #category : #accessing }
RDFLiteral >> termType [
	^ RDFTermType literal
]
