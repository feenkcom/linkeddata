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
		text: [ self description ]
]

{ #category : #'gt-extension' }
RDFNamedNode >> gtValueFor: aView [
	^ self gtIdentifierFor: aView
]

{ #category : #accessing }
RDFNamedNode >> name [
	^ self value
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
