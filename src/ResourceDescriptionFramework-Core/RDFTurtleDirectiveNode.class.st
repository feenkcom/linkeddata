Class {
	#name : #RDFTurtleDirectiveNode,
	#superclass : #RDFTurtleDocumentNode,
	#instVars : [
		'directive'
	],
	#category : #'ResourceDescriptionFramework-Core-Parsers'
}

{ #category : #generated }
RDFTurtleDirectiveNode >> acceptVisitor: aDocumentVisitor [
	^ aDocumentVisitor visitDirective: self
]

{ #category : #generated }
RDFTurtleDirectiveNode >> directive [
	^ directive
]

{ #category : #generated }
RDFTurtleDirectiveNode >> directive: aRDFTurtleDocumentNode [
	self directive notNil
		ifTrue: [ self directive parent: nil ].
	directive := aRDFTurtleDocumentNode.
	self directive notNil
		ifTrue: [ self directive parent: self ]
]

{ #category : #generated }
RDFTurtleDirectiveNode >> nodeVariables [
	^ #(#directive)
]
