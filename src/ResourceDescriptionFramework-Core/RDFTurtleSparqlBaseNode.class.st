Class {
	#name : 'RDFTurtleSparqlBaseNode',
	#superclass : 'RDFTurtleDocumentNode',
	#instVars : [
		'iri'
	],
	#category : 'ResourceDescriptionFramework-Core-Parsers'
}

{ #category : 'generated' }
RDFTurtleSparqlBaseNode >> acceptVisitor: aDocumentVisitor [
	^ aDocumentVisitor visitSparqlBase: self
]

{ #category : 'generated' }
RDFTurtleSparqlBaseNode >> iri [
	^ iri
]

{ #category : 'generated' }
RDFTurtleSparqlBaseNode >> iri: aSmaCCToken [
	iri := aSmaCCToken
]

{ #category : 'generated' }
RDFTurtleSparqlBaseNode >> tokenVariables [
	^ #(#iri)
]
