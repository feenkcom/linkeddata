"
RDFNamespaceNamedNode is an named namespace IRI, e.g. the value is a namespace such as 'http://xmlns.com/foaf/0.1/' (Friend of a Friend), and the shortName is how it is typically prefixed, e.g. 'foaf'.
"
Class {
	#name : #RDFNamespaceNamedNode,
	#superclass : #RDFNamedNode,
	#instVars : [
		'shortName'
	],
	#category : #'ResourceDescriptionFramework-Core-Model'
}

{ #category : #printing }
RDFNamespaceNamedNode >> printFullNameOn: aStream [
	self value ifNil: [ ^ super printOn: aStream ].
	aStream nextPutAll: self value asString.
]

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
