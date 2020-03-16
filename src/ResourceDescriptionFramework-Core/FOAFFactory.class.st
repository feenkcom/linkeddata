Class {
	#name : #FOAFFactory,
	#superclass : #RDFBasicFactory,
	#category : #'ResourceDescriptionFramework-Core-Factories'
}

{ #category : #factory }
FOAFFactory >> givenName [
	^ self namedNodeSuffix: 'givenName'
]

{ #category : #factory }
FOAFFactory >> prefix [
	^ 'http://xmlns.com/foaf/0.1/'
]
