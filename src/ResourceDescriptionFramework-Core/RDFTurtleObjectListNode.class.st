Class {
	#name : 'RDFTurtleObjectListNode',
	#superclass : 'RDFTurtleDocumentNode',
	#instVars : [
		'objects'
	],
	#category : 'ResourceDescriptionFramework-Core-Parsers'
}

{ #category : 'generated' }
RDFTurtleObjectListNode >> acceptVisitor: aDocumentVisitor [
	^ aDocumentVisitor visitObjectList: self
]

{ #category : 'generated' }
RDFTurtleObjectListNode >> compositeNodeVariables [
	^ #(#objects)
]

{ #category : 'generated-initialize-release' }
RDFTurtleObjectListNode >> initialize [
	super initialize.
	objects := OrderedCollection new: 2.
]

{ #category : 'generated' }
RDFTurtleObjectListNode >> objects [
	^ objects
]

{ #category : 'generated' }
RDFTurtleObjectListNode >> objects: anOrderedCollection [
	self setParents: self objects to: nil.
	objects := anOrderedCollection.
	self setParents: self objects to: self
]
