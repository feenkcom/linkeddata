Class {
	#name : #RDFTurtleIriNode,
	#superclass : #RDFTurtleDocumentNode,
	#instVars : [
		'iri'
	],
	#category : #'ResourceDescriptionFramework-Core-Parsers'
}

{ #category : #generated }
RDFTurtleIriNode >> acceptVisitor: aDocumentVisitor [
	^ aDocumentVisitor visitIri: self
]

{ #category : #converting }
RDFTurtleIriNode >> asRDFTerm [

	^ RDFNamedNode new value: self url
]

{ #category : #generated }
RDFTurtleIriNode >> iri [
	^ iri
]

{ #category : #generated }
RDFTurtleIriNode >> iri: aSmaCCToken [
	iri := aSmaCCToken
]

{ #category : #generated }
RDFTurtleIriNode >> tokenVariables [
	^ #(#iri)
]

{ #category : #accessing }
RDFTurtleIriNode >> url [ 
	"Answer the receiver's url.
	The iri is in the form '<url>'"

	^ iri value copyFrom: 2 to: iri value size - 1
]
