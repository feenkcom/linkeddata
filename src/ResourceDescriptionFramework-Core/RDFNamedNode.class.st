Class {
	#name : #RDFNamedNode,
	#superclass : #RDFTerm,
	#category : #'ResourceDescriptionFramework-Core-Model'
}

{ #category : #'gt-extension' }
RDFNamedNode >> gtIdentifierFor: aView [
	<gtView>
	self value ifNil: [ ^ aView empty ].
	^ aView textEditor
		title: 'IRI';
		glamorousCodeFontAndSize;
		text: [ self printString asString ]
]

{ #category : #accessing }
RDFNamedNode >> name [
	^ self value
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
