Class {
	#name : #RDFStore,
	#superclass : #Object,
	#category : #'ResourceDescriptionFramework-Core-Storage'
}

{ #category : #factory }
RDFStore class >> simple [
	^ RDFSimpleCollectionStore new
]

{ #category : #adding }
RDFStore >> addTriple: aRDFTriple [
	self subclassResponsibility
]
