Class {
	#name : #RDFTurtleRdfLiteralNode,
	#superclass : #RDFTurtleDocumentNode,
	#instVars : [
		'string',
		'tag',
		'iri'
	],
	#category : #'ResourceDescriptionFramework-Core-Parsers'
}

{ #category : #generated }
RDFTurtleRdfLiteralNode >> acceptVisitor: aDocumentVisitor [
	^ aDocumentVisitor visitRdfLiteral: self
]

{ #category : #converting }
RDFTurtleRdfLiteralNode >> asRDFTerm [

	^ RDFLiteral new
		value: string value dataType: iri asRDFTerm	
]

{ #category : #generated }
RDFTurtleRdfLiteralNode >> iri [
	^ iri
]

{ #category : #generated }
RDFTurtleRdfLiteralNode >> iri: aRDFTurtleIriNode [
	self iri notNil
		ifTrue: [ self iri parent: nil ].
	iri := aRDFTurtleIriNode.
	self iri notNil
		ifTrue: [ self iri parent: self ]
]

{ #category : #generated }
RDFTurtleRdfLiteralNode >> nodeVariables [
	^ #(#iri)
]

{ #category : #generated }
RDFTurtleRdfLiteralNode >> string [
	^ string
]

{ #category : #generated }
RDFTurtleRdfLiteralNode >> string: aSmaCCToken [
	string := aSmaCCToken
]

{ #category : #generated }
RDFTurtleRdfLiteralNode >> tag [
	^ tag
]

{ #category : #generated }
RDFTurtleRdfLiteralNode >> tag: aSmaCCToken [
	tag := aSmaCCToken
]

{ #category : #generated }
RDFTurtleRdfLiteralNode >> tokenVariables [
	^ #(#string #tag)
]
