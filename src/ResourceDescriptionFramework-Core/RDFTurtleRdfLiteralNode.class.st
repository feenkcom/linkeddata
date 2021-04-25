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
RDFTurtleRdfLiteralNode >> asRDFTermFor: aVisitor [

	^ iri
		ifNil: [ RDFLiteral new value: string value ]
		ifNotNil: [ RDFLiteral new value: string value dataType: (iri asRDFTermFor: aVisitor) ]
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
	^ #(#string #iri)
]

{ #category : #generated }
RDFTurtleRdfLiteralNode >> string [
	^ string
]

{ #category : #generated }
RDFTurtleRdfLiteralNode >> string: aRDFTurtleDocumentNode [
	self string notNil
		ifTrue: [ self string parent: nil ].
	string := aRDFTurtleDocumentNode.
	self string notNil
		ifTrue: [ self string parent: self ]
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
	^ #(#tag)
]
