Class {
	#name : #RDFTurtleSubjectNode,
	#superclass : #RDFTurtleDocumentNode,
	#instVars : [
		'subject'
	],
	#category : #'ResourceDescriptionFramework-Core-Parsers'
}

{ #category : #generated }
RDFTurtleSubjectNode >> acceptVisitor: aDocumentVisitor [
	^ aDocumentVisitor visitSubject: self
]

{ #category : #converting }
RDFTurtleSubjectNode >> asRDFTerm [

	^ subject asRDFTerm
]

{ #category : #generated }
RDFTurtleSubjectNode >> otherVariables [
	^ #(#subject)
]

{ #category : #generated }
RDFTurtleSubjectNode >> subject [
	^ subject
]

{ #category : #generated }
RDFTurtleSubjectNode >> subject: anObject [
	self setParent: self subject to: nil.
	subject := anObject.
	self setParent: self subject to: self
]
