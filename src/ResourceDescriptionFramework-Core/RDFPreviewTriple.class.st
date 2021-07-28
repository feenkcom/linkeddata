Class {
	#name : 'RDFPreviewTriple',
	#superclass : 'RDFPreviewObject',
	#category : 'ResourceDescriptionFramework-Core-Helpers'
}

{ #category : 'accessing' }
RDFPreviewTriple >> object [
	^ self realObject object
]

{ #category : 'accessing' }
RDFPreviewTriple >> predicate [
	^ self realObject predicate
]

{ #category : 'accessing' }
RDFPreviewTriple >> subject [
	^ self realObject subject
]
