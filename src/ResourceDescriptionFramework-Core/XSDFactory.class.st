Class {
	#name : #XSDFactory,
	#superclass : #RDFTermFactory,
	#category : #'ResourceDescriptionFramework-Core-Factories'
}

{ #category : #factory }
XSDFactory >> date [
	<return: #RDFNamedNode>
	^ self namedNodeSuffix: 'date'
]

{ #category : #factory }
XSDFactory >> dateTime [
	<return: #RDFNamedNode>
	^ self namedNodeSuffix: 'dateTime'
]

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
