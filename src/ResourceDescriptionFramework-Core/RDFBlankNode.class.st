Class {
	#name : #RDFBlankNode,
	#superclass : #RDFTerm,
	#category : #'ResourceDescriptionFramework-Core-Model'
}

{ #category : #accessing }
RDFBlankNode >> termType [
	^ RDFTermType blankNode
]
