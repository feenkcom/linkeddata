Class {
	#name : #RDFTurtleSparqlPrefixNode,
	#superclass : #RDFTurtleDocumentNode,
	#instVars : [
		'name',
		'iri'
	],
	#category : 'ResourceDescriptionFramework-Core-Parsers'
}

{ #category : #generated }
RDFTurtleSparqlPrefixNode >> acceptVisitor: aDocumentVisitor [
	^ aDocumentVisitor visitSparqlPrefix: self
]

{ #category : #generated }
RDFTurtleSparqlPrefixNode >> iri [
	^ iri
]

{ #category : #generated }
RDFTurtleSparqlPrefixNode >> iri: aSmaCCToken [
	iri := aSmaCCToken
]

{ #category : #generated }
RDFTurtleSparqlPrefixNode >> name [
	^ name
]

{ #category : #generated }
RDFTurtleSparqlPrefixNode >> name: aSmaCCToken [
	name := aSmaCCToken
]

{ #category : #generated }
RDFTurtleSparqlPrefixNode >> tokenVariables [
	^ #(#name #iri)
]
