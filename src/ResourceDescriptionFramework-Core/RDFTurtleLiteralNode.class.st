Class {
	#name : #RDFTurtleLiteralNode,
	#superclass : #RDFTurtleDocumentNode,
	#instVars : [
		'literal'
	],
	#category : #'ResourceDescriptionFramework-Core-Parsers'
}

{ #category : #generated }
RDFTurtleLiteralNode >> acceptVisitor: aDocumentVisitor [
	^ aDocumentVisitor visitLiteral: self
]

{ #category : #converting }
RDFTurtleLiteralNode >> asRDFTerm [ 

	^ literal asRDFTerm
]

{ #category : #generated }
RDFTurtleLiteralNode >> literal [
	^ literal
]

{ #category : #generated }
RDFTurtleLiteralNode >> literal: aRDFTurtleDocumentNode [
	self literal notNil
		ifTrue: [ self literal parent: nil ].
	literal := aRDFTurtleDocumentNode.
	self literal notNil
		ifTrue: [ self literal parent: self ]
]

{ #category : #generated }
RDFTurtleLiteralNode >> nodeVariables [
	^ #(#literal)
]
