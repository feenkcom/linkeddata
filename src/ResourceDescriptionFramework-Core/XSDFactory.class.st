Class {
	#name : #XSDFactory,
	#superclass : #RDFTermFactory,
	#category : #'ResourceDescriptionFramework-Core-Factories'
}

{ #category : #factory }
XSDFactory >> string [
	<return: #RDFNamedNode>
	^ self namedNode: 'http://www.w3.org/2001/XMLSchema#string'
]
