Class {
	#name : #RDFTurtleCollectionNode,
	#superclass : #RDFTurtleDocumentNode,
	#instVars : [
		'objects'
	],
	#category : #'ResourceDescriptionFramework-Core-Parsers'
}

{ #category : #generated }
RDFTurtleCollectionNode >> acceptVisitor: aDocumentVisitor [
	^ aDocumentVisitor visitCollection: self
]

{ #category : #'generated-initialize-release' }
RDFTurtleCollectionNode >> initialize [
	super initialize.
	objects := OrderedCollection new: 2.
]

{ #category : #generated }
RDFTurtleCollectionNode >> objects [
	^ objects
]

{ #category : #generated }
RDFTurtleCollectionNode >> objects: anOrderedCollection [
	self setParent: self objects to: nil.
	objects := anOrderedCollection.
	self setParent: self objects to: self
]

{ #category : #generated }
RDFTurtleCollectionNode >> otherVariables [
	^ #(#objects)
]
