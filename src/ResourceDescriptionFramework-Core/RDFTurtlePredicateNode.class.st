Class {
	#name : #RDFTurtlePredicateNode,
	#superclass : #RDFTurtleDocumentNode,
	#instVars : [
		'iri'
	],
	#category : 'ResourceDescriptionFramework-Core-Parsers'
}

{ #category : #generated }
RDFTurtlePredicateNode >> acceptVisitor: aDocumentVisitor [
	^ aDocumentVisitor visitPredicate: self
]

{ #category : #converting }
RDFTurtlePredicateNode >> asRDFTermFor: aVisitor [

	^ iri asRDFTermFor: aVisitor
]

{ #category : #generated }
RDFTurtlePredicateNode >> iri [
	^ iri
]

{ #category : #generated }
RDFTurtlePredicateNode >> iri: aRDFTurtleIriNode [
	self iri notNil
		ifTrue: [ self iri parent: nil ].
	iri := aRDFTurtleIriNode.
	self iri notNil
		ifTrue: [ self iri parent: self ]
]

{ #category : #generated }
RDFTurtlePredicateNode >> nodeVariables [
	^ #(#iri)
]
