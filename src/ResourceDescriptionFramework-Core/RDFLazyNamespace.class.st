Class {
	#name : #RDFLazyNamespace,
	#superclass : #RDFTermFactory,
	#instVars : [
		'shortName',
		'prefix'
	],
	#category : 'ResourceDescriptionFramework-Core-Factories'
}

{ #category : #testing }
RDFLazyNamespace class >> isDynamic [
	"Answer a boolean indicating whether the receiver is a dynamic factory, i.e. doesn't have a fixed prefix and shortName"

	^ true
]

{ #category : #accessing }
RDFLazyNamespace >> prefix [
	^ prefix
]

{ #category : #accessing }
RDFLazyNamespace >> prefix: anObject [
	prefix := anObject
]

{ #category : #properties }
RDFLazyNamespace >> propertyNamed: aString [ 

	^ self namedNodeSuffix: aString
]

{ #category : #accessing }
RDFLazyNamespace >> shortName [
	^ shortName
]

{ #category : #accessing }
RDFLazyNamespace >> shortName: anObject [
	shortName := anObject
]
