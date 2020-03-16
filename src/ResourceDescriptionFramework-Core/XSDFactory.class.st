Class {
	#name : #XSDFactory,
	#superclass : #RDFBasicFactory,
	#category : #'ResourceDescriptionFramework-Core-Factories'
}

{ #category : #accessing }
XSDFactory >> namedNode: aString [
	<return: #RDFNamedNode>
	^ RDF namedNode: 'http://www.w3.org/2001/XMLSchema#string'
]

{ #category : #accessing }
XSDFactory >> string [
	<return: #RDFNamedNode>
	^ self namedNode: 'http://www.w3.org/2001/XMLSchema#string'
]
