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
RDFTurtleVerbNode >> asRDFTerm [

	^ verb asRDFTerm
]

{ #category : #generated }
RDFTurtleVerbNode >> otherVariables [
	^ #(#verb)
]

{ #category : #generated }
RDFTurtleVerbNode >> verb [
	^ verb
]

{ #category : #generated }
RDFTurtleVerbNode >> verb: anObject [
	self setParent: self verb to: nil.
	verb := anObject.
	self setParent: self verb to: self
]
