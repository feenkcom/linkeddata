Class {
	#name : #RDFAuxiliaryTriple,
	#superclass : #RDFAuxiliaryObject,
	#category : #'ResourceDescriptionFramework-Core-Helpers'
}

{ #category : #accessing }
RDFAuxiliaryTriple >> object [
	^ self realObject object
]

{ #category : #accessing }
RDFAuxiliaryTriple >> predicate [
	^ self realObject predicate
]

{ #category : #accessing }
RDFAuxiliaryTriple >> subject [
	^ self realObject subject
]
