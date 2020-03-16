Class {
	#name : #RDFS,
	#superclass : #RDFConvenience,
	#category : #'ResourceDescriptionFramework-Core-Factories'
}

{ #category : #factory }
RDFS class >> factory [
	^ RDFSFactory default
]
