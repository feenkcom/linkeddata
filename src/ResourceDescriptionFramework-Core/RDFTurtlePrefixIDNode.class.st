Class {
	#name : #RDFTurtlePrefixIDNode,
	#superclass : #RDFTurtleDocumentNode,
	#instVars : [
		'name',
		'iri'
	],
	#category : 'ResourceDescriptionFramework-Core-Parsers'
}

{ #category : #generated }
RDFTurtlePrefixIDNode >> acceptVisitor: aDocumentVisitor [
	^ aDocumentVisitor visitPrefixID: self
]

{ #category : #generated }
RDFTurtlePrefixIDNode >> iri [
	^ iri
]

{ #category : #generated }
RDFTurtlePrefixIDNode >> iri: aSmaCCToken [
	iri := aSmaCCToken
]

{ #category : #generated }
RDFTurtlePrefixIDNode >> name [
	^ name
]

{ #category : #generated }
RDFTurtlePrefixIDNode >> name: aSmaCCToken [
	name := aSmaCCToken
]

{ #category : #generated }
RDFTurtlePrefixIDNode >> tokenVariables [
	^ #(#name #iri)
]
