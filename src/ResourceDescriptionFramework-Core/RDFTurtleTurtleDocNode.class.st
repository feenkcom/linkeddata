Class {
	#name : 'RDFTurtleTurtleDocNode',
	#superclass : 'RDFTurtleDocumentNode',
	#instVars : [
		'statementses'
	],
	#category : 'ResourceDescriptionFramework-Core-Parsers'
}

{ #category : 'generated' }
RDFTurtleTurtleDocNode >> acceptVisitor: aDocumentVisitor [
	^ aDocumentVisitor visitTurtleDoc: self
]

{ #category : 'generated' }
RDFTurtleTurtleDocNode >> compositeNodeVariables [
	^ #(#statementses)
]

{ #category : 'generated-initialize-release' }
RDFTurtleTurtleDocNode >> initialize [
	super initialize.
	statementses := OrderedCollection new: 2.
]

{ #category : 'generated' }
RDFTurtleTurtleDocNode >> statementses [
	^ statementses
]

{ #category : 'generated' }
RDFTurtleTurtleDocNode >> statementses: anOrderedCollection [
	self setParents: self statementses to: nil.
	statementses := anOrderedCollection.
	self setParents: self statementses to: self
]
