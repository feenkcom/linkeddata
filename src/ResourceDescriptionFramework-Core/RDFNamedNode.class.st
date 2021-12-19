"
RDFNamedNode holds an unnamed IRI.

"
Class {
	#name : #RDFNamedNode,
	#superclass : #RDFTerm,
	#instVars : [
		'parser',
		'printer'
	],
	#category : 'ResourceDescriptionFramework-Core-Model'
}

{ #category : #'instance creation' }
RDFNamedNode class >> fromJsonDictionary: aDictionary [
	"Answer an instance of the appropriate subclass.
	aDictionary follows the structure defined at https://www.w3.org/TR/sparql11-results-json/"

	^ self new value: (aDictionary at: #value) urlDecoded
]

{ #category : #accessing }
RDFNamedNode class >> typeName [ 
	"Answer the type the receiver represents."

	^ #uri
]

{ #category : #converting }
RDFNamedNode >> asPredicate [

	^ RDFPredicate term: self
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
RDFNamedNode >> iri [

	^ value
]

{ #category : #accessing }
RDFNamedNode >> name [
	^ self value
]

{ #category : #accessing }
RDFNamedNode >> parser [
	"Answer an optional BlockClosure that parses the receiver's string representation, or nil"
	<return: #BlockClosure or: nil>

	^ parser
]

{ #category : #accessing }
RDFNamedNode >> parser: aBlockClosure [
	"Set the block closure that knows how to parse the receiver's string representation"

	parser := aBlockClosure
]

{ #category : #printing }
RDFNamedNode >> print: anObject onSparqlStream: aStream [

	printer
		ifNil: [ anObject printSparqlOn: aStream ]
		ifNotNil: [ aStream << (printer value: anObject) ].

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

{ #category : #printing }
RDFNamedNode >> printSparqlOn: aStream [
	"Print the SPARQL syntax encoding of the receiver on the supplied stream.
	See: https://www.w3.org/TR/2013/REC-sparql11-query-20130321"

	aStream 
		nextPut: $<;
		<< self iri;
		nextPut: $>
]

{ #category : #accessing }
RDFNamedNode >> printer [
	"Answer an optional BlockClosure that prints the receiver's string representation, or nil"
	<return: #BlockClosure or: nil>

	^ printer
]

{ #category : #accessing }
RDFNamedNode >> printer: aBlockClosure [

	printer := aBlockClosure
]

{ #category : #accessing }
RDFNamedNode >> termType [
	^ RDFTermType namedNode
]
