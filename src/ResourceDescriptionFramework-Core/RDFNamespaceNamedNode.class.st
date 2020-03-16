Class {
	#name : #RDFNamespaceNamedNode,
	#superclass : #RDFNamedNode,
	#instVars : [
		'shortName'
	],
	#category : #'ResourceDescriptionFramework-Core-Model'
}

{ #category : #printing }
RDFNamespaceNamedNode >> printOn: aStream [
	self value ifNil: [ ^ super printOn: aStream ].
	aStream nextPutAll: self shortName asString; nextPutAll: ' = '.
	super printOn: aStream. 
]

{ #category : #accessing }
RDFNamespaceNamedNode >> shortName [
	^ shortName
]

{ #category : #accessing }
RDFNamespaceNamedNode >> shortName: anObject [
	shortName := anObject
]
