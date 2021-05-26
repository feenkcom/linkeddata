Class {
	#name : #RDFTurtleBlankNodePropertyListNode,
	#superclass : #RDFTurtleDocumentNode,
	#instVars : [
		'list'
	],
	#category : #'ResourceDescriptionFramework-Core-Parsers'
}

{ #category : #generated }
RDFTurtleBlankNodePropertyListNode >> acceptVisitor: aDocumentVisitor [
	^ aDocumentVisitor visitBlankNodePropertyList: self
]

{ #category : #converting }
RDFTurtleBlankNodePropertyListNode >> asRDFTermFor: aVisitor [

	^ RDFBlankNode new label: aVisitor nextBlankNodeIndex 
]

{ #category : #generated }
RDFTurtleBlankNodePropertyListNode >> list [
	^ list
]

{ #category : #generated }
RDFTurtleBlankNodePropertyListNode >> list: aRDFTurtlePredicateObjectListNode [
	self list notNil
		ifTrue: [ self list parent: nil ].
	list := aRDFTurtlePredicateObjectListNode.
	self list notNil
		ifTrue: [ self list parent: self ]
]

{ #category : #generated }
RDFTurtleBlankNodePropertyListNode >> nodeVariables [
	^ #(#list)
]
