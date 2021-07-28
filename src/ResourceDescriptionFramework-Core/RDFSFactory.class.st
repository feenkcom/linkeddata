Class {
	#name : 'RDFSFactory',
	#superclass : 'RDFTermFactory',
	#category : 'ResourceDescriptionFramework-Core-Factories'
}

{ #category : 'factory' }
RDFSFactory >> prefix [
	^ 'http://www.w3.org/2000/01/rdf-schema#'
]

{ #category : 'factory' }
RDFSFactory >> shortName [
	^ 'rdfs'
]
