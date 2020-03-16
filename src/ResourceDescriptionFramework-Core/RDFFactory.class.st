Class {
	#name : #RDFFactory,
	#superclass : #RDFBasicFactory,
	#category : #'ResourceDescriptionFramework-Core-Factories'
}

{ #category : #factory }
RDFFactory >> predicate: aTerm [
	^ RDFPredicate new term: aTerm
]

{ #category : #accessing }
RDFFactory >> string [
	<return: #RDFNamedNode>
	^ self namedNode: 'http://www.w3.org/2001/XMLSchema#string'
]
