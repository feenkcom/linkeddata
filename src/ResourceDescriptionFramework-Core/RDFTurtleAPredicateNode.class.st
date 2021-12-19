Class {
	#name : #RDFTurtleAPredicateNode,
	#superclass : #RDFTurtleDocumentNode,
	#category : 'ResourceDescriptionFramework-Core-Parsers'
}

{ #category : #generated }
RDFTurtleAPredicateNode >> acceptVisitor: aDocumentVisitor [
	^ aDocumentVisitor visitAPredicate: self
]

{ #category : #converting }
RDFTurtleAPredicateNode >> asRDFTermFor: aVisitor [

	^ RDF type
]
