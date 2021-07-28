Class {
	#name : 'RDFTurtleObjectNode',
	#superclass : 'RDFTurtleDocumentNode',
	#instVars : [
		'object'
	],
	#category : 'ResourceDescriptionFramework-Core-Parsers'
}

{ #category : 'generated' }
RDFTurtleObjectNode >> acceptVisitor: aDocumentVisitor [
	^ aDocumentVisitor visitObject: self
]

{ #category : 'converting' }
RDFTurtleObjectNode >> asRDFTermFor: aVisitor [

	^ object asRDFTermFor: aVisitor
]

{ #category : 'generated' }
RDFTurtleObjectNode >> object [
	^ object
]

{ #category : 'generated' }
RDFTurtleObjectNode >> object: anObject [
	self setParent: self object to: nil.
	object := anObject.
	self setParent: self object to: self
]

{ #category : 'generated' }
RDFTurtleObjectNode >> otherVariables [
	^ #(#object)
]
