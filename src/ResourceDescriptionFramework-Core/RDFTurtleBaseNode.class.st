Class {
	#name : #RDFTurtleBaseNode,
	#superclass : #RDFTurtleDocumentNode,
	#instVars : [
		'iri'
	],
	#category : 'ResourceDescriptionFramework-Core-Parsers'
}

{ #category : #generated }
RDFTurtleBaseNode >> acceptVisitor: aDocumentVisitor [
	^ aDocumentVisitor visitBase: self
]

{ #category : #generated }
RDFTurtleBaseNode >> iri [
	^ iri
]

{ #category : #generated }
RDFTurtleBaseNode >> iri: aSmaCCToken [
	iri := aSmaCCToken
]

{ #category : #generated }
RDFTurtleBaseNode >> tokenVariables [
	^ #(#iri)
]
