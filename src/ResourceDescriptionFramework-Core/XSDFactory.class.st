Class {
	#name : #XSDFactory,
	#superclass : #RDFTermFactory,
	#category : #'ResourceDescriptionFramework-Core-Factories'
}

{ #category : #factory }
XSDFactory >> prefix [
	<return: #String>
	^ 'http://www.w3.org/2001/XMLSchema#'
]

{ #category : #factory }
XSDFactory >> shortName [
	^ 'xsd'
]

{ #category : #factory }
XSDFactory >> string [
	<return: #RDFNamedNode>
	^ self namedNodeSuffix: 'string'
]
