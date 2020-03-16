Class {
	#name : #RDFTriplePart,
	#superclass : #RDFProtoObject,
	#instVars : [
		'term'
	],
	#category : #'ResourceDescriptionFramework-Core-Model'
}

{ #category : #'gt-extension' }
RDFTriplePart >> gtTermFor: aView [
	<gtView>
	self term ifNil: [ ^ aView empty ].
	^ aView forward
		title: self term termType name;
		object: [ self term ];
		view: #gtValueFor:
]

{ #category : #printing }
RDFTriplePart >> printOn: aStream [
	self term ifNil: [ ^ super printOn: aStream ].
	self term printShortOn: aStream.
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
