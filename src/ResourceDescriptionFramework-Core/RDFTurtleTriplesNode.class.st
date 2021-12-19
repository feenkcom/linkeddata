Class {
	#name : #RDFTurtleTriplesNode,
	#superclass : #RDFTurtleDocumentNode,
	#instVars : [
		'subject',
		'predicateObject'
	],
	#category : 'ResourceDescriptionFramework-Core-Parsers'
}

{ #category : #generated }
RDFTurtleTriplesNode >> acceptVisitor: aDocumentVisitor [
	^ aDocumentVisitor visitTriples: self
]

{ #category : #generated }
RDFTurtleTriplesNode >> nodeVariables [
	^ #(#subject #predicateObject)
]

{ #category : #generated }
RDFTurtleTriplesNode >> predicateObject [
	^ predicateObject
]

{ #category : #generated }
RDFTurtleTriplesNode >> predicateObject: aRDFTurtlePredicateObjectListNode [
	self predicateObject notNil
		ifTrue: [ self predicateObject parent: nil ].
	predicateObject := aRDFTurtlePredicateObjectListNode.
	self predicateObject notNil
		ifTrue: [ self predicateObject parent: self ]
]

{ #category : #generated }
RDFTurtleTriplesNode >> subject [
	^ subject
]

{ #category : #generated }
RDFTurtleTriplesNode >> subject: aRDFTurtleDocumentNode [
	self subject notNil
		ifTrue: [ self subject parent: nil ].
	subject := aRDFTurtleDocumentNode.
	self subject notNil
		ifTrue: [ self subject parent: self ]
]
