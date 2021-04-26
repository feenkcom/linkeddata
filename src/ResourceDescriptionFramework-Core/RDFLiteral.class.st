Class {
	#name : #RDFLiteral,
	#superclass : #RDFTerm,
	#instVars : [
		'language',
		'dataType'
	],
	#category : #'ResourceDescriptionFramework-Core-Model'
}

{ #category : #'instance creation' }
RDFLiteral class >> fromJsonDictionary: aDictionary [
	"Answer an instance of the appropriate subclass.
	aDictionary follows the structure defined at https://www.w3.org/TR/sparql11-results-json/"

	^ self new 
		language: (aDictionary at: #'xml:lang' ifAbsent: []);
		value: (aDictionary at: #value)
			dataType: (aDictionary at: #datatype 
				ifPresent: [ :datatype | RDFConvenience iriAt: datatype ]
				ifAbsent: []);
		yourself
]

{ #category : #accessing }
RDFLiteral class >> typeName [ 
	"Answer the type the receiver represents."

	^ #literal
]

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

{ #category : #comparing }
RDFLiteral >> equals: aRDFTerm [
	^ (super equals: aRDFTerm) and: [ 
		self dataType = aRDFTerm dataType and: [ 
			self language = aRDFTerm language ] ]
]

{ #category : #'gt-extension' }
RDFLiteral >> gtAttributesFor: aView [
	<gtView>
	self value ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Attributes';
		items: [ { 'Value' -> self value. 'Language' -> self language. 'Data type' -> self dataType } ];
		column: 'Description' item: [ :anAssoc | anAssoc key ] width: 80;
		column: 'Value' item: [ :anAssoc | anAssoc value ];
		send: [ :anAssoc | anAssoc value ]
]

{ #category : #'gt-extension' }
RDFLiteral >> gtValueFor: aView [
	<gtView>
	self value ifNil: [ ^ aView empty ].
	^ aView textEditor
		title: 'Value';
		text: [ self value asString ]
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
RDFLiteral >> printDescriptionOn: aStream [
	self value ifNil: [ ^ self printOn: aStream ].
	aStream nextPutAll: self dataType asString.
	aStream nextPutAll: ' '.
	aStream nextPutAll: self value asString.
	self language ifNotNil: [ 
		aStream nextPut: $@; print: self language ]
]

{ #category : #printing }
RDFLiteral >> printFullNameOn: aStream [
	self value ifNil: [ ^ self printOn: aStream ].
	aStream nextPutAll: self value asString
]

{ #category : #printing }
RDFLiteral >> printFullNameWithDataTypeOn: aStream [
	self value ifNil: [ ^ self printFullNameOn: aStream ].
	aStream 
		print: self dataType;
		nextPutAll: ': ';
		nextPutAll: self value asString
]

{ #category : #printing }
RDFLiteral >> printOn: aStream [
	self value ifNil: [ ^ super printOn: aStream ].
	aStream nextPutAll: self value asString.
	self language ifNil: [ ^ self ].
	aStream nextPut: $@; print: self language. 
]

{ #category : #printing }
RDFLiteral >> printShortNameOn: aStream [
	self value ifNil: [ ^ self printOn: aStream ].
	aStream nextPutAll: self value asString.
]

{ #category : #printing }
RDFLiteral >> printSparqlOn: aStream [
	"Print the SPARQL syntax encoding of the receiver on the supplied stream.
	See: https://www.w3.org/TR/2013/REC-sparql11-query-20130321"

	dataType
		ifNil: [ (RDFNamedNode new value: #string) print: value onSparqlStream: aStream ]
		ifNotNil: [ dataType print: value onSparqlStream: aStream ]
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

{ #category : #accessing }
RDFLiteral >> value: anObject dataType: aRDFNamedNode [
	"Set the receiver's type and value, decoding the supplied string for common types"

	dataType := aRDFNamedNode.
	value := dataType
		ifNil: [ anObject ]
		ifNotNil: [ dataType parser
			ifNil: [ anObject ]
			ifNotNil: [ :parser | parser value: anObject ] ].
]
