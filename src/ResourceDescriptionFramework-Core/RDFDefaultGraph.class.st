Class {
	#name : #RDFDefaultGraph,
	#superclass : #RDFTerm,
	#category : #'ResourceDescriptionFramework-Core-Model'
}

{ #category : #accessing }
RDFDefaultGraph >> termType [
	^ RDFTermType defaultGraph
]
