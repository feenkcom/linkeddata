Class {
	#name : #XSDFactory,
	#superclass : #RDFBasicFactory,
	#category : #'ResourceDescriptionFramework-Core-Factories'
}

{ #category : #factory }
XSDFactory >> string [
	<return: #RDFNamedNode>
	^ self namedNode: 'http://www.w3.org/2001/XMLSchema#string'
]
