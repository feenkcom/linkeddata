Class {
	#name : #RDFTurtleStatementNode,
	#superclass : #RDFTurtleDocumentNode,
	#instVars : [
		'statement'
	],
	#category : #'ResourceDescriptionFramework-Core-Parsers'
}

{ #category : #generated }
RDFTurtleStatementNode >> acceptVisitor: aDocumentVisitor [
	^ aDocumentVisitor visitStatement: self
]

{ #category : #generated }
RDFTurtleStatementNode >> nodeVariables [
	^ #(#statement)
]

{ #category : #generated }
RDFTurtleStatementNode >> statement [
	^ statement
]

{ #category : #generated }
RDFTurtleStatementNode >> statement: aRDFTurtleDocumentNode [
	self statement notNil
		ifTrue: [ self statement parent: nil ].
	statement := aRDFTurtleDocumentNode.
	self statement notNil
		ifTrue: [ self statement parent: self ]
]
