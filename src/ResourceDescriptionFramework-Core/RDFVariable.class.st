Class {
	#name : #RDFVariable,
	#superclass : #RDFTerm,
	#category : #'ResourceDescriptionFramework-Core-Model'
}

{ #category : #accessing }
RDFVariable >> termType [
	^ RDFTermType variable
]
