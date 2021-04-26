Class {
	#name : #RDFTurtleVerbNode,
	#superclass : #RDFTurtleDocumentNode,
	#instVars : [
		'verb'
	],
	#category : #'ResourceDescriptionFramework-Core-Parsers'
}

{ #category : #generated }
RDFTurtleVerbNode >> acceptVisitor: aDocumentVisitor [
	^ aDocumentVisitor visitVerb: self
]

{ #category : #converting }
RDFTurtleVerbNode >> asRDFTermFor: aVisitor [

	^ verb asRDFTermFor: aVisitor
]

{ #category : #generated }
RDFTurtleVerbNode >> nodeVariables [
	^ #(#verb)
]

{ #category : #generated }
RDFTurtleVerbNode >> verb [
	^ verb
]

{ #category : #generated }
RDFTurtleVerbNode >> verb: aRDFTurtleDocumentNode [
	self verb notNil
		ifTrue: [ self verb parent: nil ].
	verb := aRDFTurtleDocumentNode.
	self verb notNil
		ifTrue: [ self verb parent: self ]
]
