Class {
	#name : #RDFNamedNode,
	#superclass : #RDFTerm,
	#instVars : [
		'parser'
	],
	#category : #'ResourceDescriptionFramework-Core-Model'
}

{ #category : #'instance creation' }
RDFNamedNode class >> fromJsonDictionary: aDictionary [
	"Answer an instance of the appropriate subclass.
	aDictionary follows the structure defined at https://www.w3.org/TR/sparql11-results-json/"

	^ self new value: (aDictionary at: #value)
]

{ #category : #accessing }
RDFNamedNode class >> typeName [ 
	"Answer the type the receiver represents."

	^ #uri
]

{ #category : #comparing }
RDFNamedNode >> equals: anObject [
	<return: #Boolean>

	^ (anObject isKindOf: RDFNamedNode) and: [ self name = anObject name ]
]

{ #category : #'gt-extension' }
RDFNamedNode >> gtIdentifierFor: aView [
	<gtView>
	self value ifNil: [ ^ aView empty ].
	^ aView textEditor
		title: 'IRI';
		glamorousCodeFontAndSize;
		text: [ self description ]
]

{ #category : #'gt-extension' }
RDFNamedNode >> gtValueFor: aView [
	^ self gtIdentifierFor: aView
]

{ #category : #comparing }
RDFNamedNode >> hash [ 

	^ self name hash
]

{ #category : #accessing }
RDFNamedNode >> name [
	^ self value
]

{ #category : #accessing }
RDFNamedNode >> parser [
	"Answer an optional BlockClosure that parses the receiver's string representation, or nil"
	<return: #BlockClosure>

	^ parser
]

{ #category : #accessing }
RDFNamedNode >> parser: aBlockClosure [
	"Set the block closure that knows how to parse the receiver's string representation"

	parser := aBlockClosure
]

{ #category : #printing }
RDFNamedNode >> print: anObject onSparqlStream: aStream [

	value = #string ifTrue: 
		[ aStream 
			<< '"""';
			<< anObject;
			<< '"""' ]
	ifFalse: [ value = #date ifTrue: 
		[ aStream
			nextPut: $";
			print: anObject;
			<< '"^^xsd:dateTime' ]
	ifFalse: [ value = #decimal ifTrue:
		[ anObject printOn: aStream showingDecimalPlaces: anObject scale ]
	ifFalse:
		[ aStream print: anObject ] ] ]
]

{ #category : #printing }
RDFNamedNode >> printDescriptionOn: aStream [
	aStream print: self
]

{ #category : #printing }
RDFNamedNode >> printFullNameWithDataTypeOn: aStream [
	self value ifNil: [ ^ self printOn: aStream ].
	aStream nextPutAll: 'IRI: '.
	self printFullNameOn: aStream.
]

{ #category : #printing }
RDFNamedNode >> printOn: aStream [
	self value ifNil: [ ^ super printOn: aStream ].
	aStream nextPutAll: self value asString.
]

{ #category : #accessing }
RDFNamedNode >> termType [
	^ RDFTermType namedNode
]
