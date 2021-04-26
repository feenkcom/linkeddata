Class {
	#name : #RDFTurtleDocumentNode,
	#superclass : #SmaCCParseNode,
	#category : #'ResourceDescriptionFramework-Core-Parsers'
}

{ #category : #generated }
RDFTurtleDocumentNode >> acceptVisitor: aDocumentVisitor [
	^ aDocumentVisitor visitDocument: self
]
