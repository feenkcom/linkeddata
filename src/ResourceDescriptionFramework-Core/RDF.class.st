Class {
	#name : #RDF,
	#superclass : #RDFConvenience,
	#category : #'ResourceDescriptionFramework-Core-Factories'
}

{ #category : #accessing }
RDF class >> factory [
	^ RDFFactory default
]

{ #category : #factory }
RDF class >> namedNode: aString [
	^ self factory namedNode: aString
]
