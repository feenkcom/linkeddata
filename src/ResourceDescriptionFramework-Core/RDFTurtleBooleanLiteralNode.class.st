Class {
	#name : 'RDFTurtleBooleanLiteralNode',
	#superclass : 'RDFTurtleDocumentNode',
	#instVars : [
		'literal'
	],
	#category : 'ResourceDescriptionFramework-Core-Parsers'
}

{ #category : 'generated' }
RDFTurtleBooleanLiteralNode >> acceptVisitor: aDocumentVisitor [
	^ aDocumentVisitor visitBooleanLiteral: self
]

{ #category : 'converting' }
RDFTurtleBooleanLiteralNode >> asRDFTermFor: aVisitor [

	^ RDFLiteral new value: literal value dataType: RdfResources boolean
]

{ #category : 'generated' }
RDFTurtleBooleanLiteralNode >> literal [
	^ literal
]

{ #category : 'generated' }
RDFTurtleBooleanLiteralNode >> literal: aSmaCCToken [
	literal := aSmaCCToken
]

{ #category : 'generated' }
RDFTurtleBooleanLiteralNode >> tokenVariables [
	^ #(#literal)
]
