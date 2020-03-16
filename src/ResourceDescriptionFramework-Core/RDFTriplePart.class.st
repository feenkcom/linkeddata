Class {
	#name : #RDFTriplePart,
	#superclass : #RDFProtoObject,
	#instVars : [
		'term'
	],
	#category : #'ResourceDescriptionFramework-Core-Model'
}

{ #category : #printing }
RDFTriplePart >> printOn: aStream [
	self term ifNil: [ ^ super printOn: aStream ].
	aStream print: term
]

{ #category : #accessing }
RDFTriplePart >> term [
	<return: #RDFTerm>
	^ term
]

{ #category : #accessing }
RDFTriplePart >> term: aRDFTerm [
	self 
		assert: [ aRDFTerm isNotNil ]
		description: [ 'Triple part term must be non-nil' ].
	term := aRDFTerm
]
