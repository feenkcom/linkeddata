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
RDFTurtleLiteralNode >> literal: anObject [
	self setParent: self literal to: nil.
	literal := anObject.
	self setParent: self literal to: self
]

{ #category : #generated }
RDFTurtleLiteralNode >> otherVariables [
	^ #(#literal)
]
