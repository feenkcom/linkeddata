Class {
	#name : #RDFFactory,
	#superclass : #RDFTermFactory,
	#category : #'ResourceDescriptionFramework-Core-Factories'
}

{ #category : #factory }
RDFFactory >> object: aTerm [
	^ RDFObject new term: aTerm
]

{ #category : #factory }
RDFFactory >> predicate: aTerm [
	^ RDFPredicate new term: aTerm
]

{ #category : #factory }
RDFFactory >> prefix [
	^ 'http://www.w3.org/1999/02/22-rdf-syntax-ns#'
]

{ #category : #accessing }
RDFFactory >> string [
	<return: #RDFNamedNode>
	^ self namedNode: 'http://www.w3.org/2001/XMLSchema#string'
]

{ #category : #factory }
RDFFactory >> subject: aTerm [
	^ RDFSubject new term: aTerm
]
