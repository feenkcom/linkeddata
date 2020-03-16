Class {
	#name : #RDFShortNamedNode,
	#superclass : #RDFNamedNode,
	#instVars : [
		'namespace'
	],
	#category : #'ResourceDescriptionFramework-Core-Model'
}

{ #category : #accessing }
RDFShortNamedNode >> namespace [
	<return: #RDFNamespaceNamedNode>
	^ namespace
]

{ #category : #accessing }
RDFShortNamedNode >> namespace: aRDFNamespaceNamedNode [
	self 
		assert: [ aRDFNamespaceNamedNode isNotNil ] 
		description: [ 'Namespace must be non-nil' ].
	namespace := aRDFNamespaceNamedNode
]

{ #category : #printing }
RDFShortNamedNode >> printOn: aStream [
	self value ifNil: [ ^ super printOn: aStream ].
	self namespace ifNil: [ ^ super printOn: aStream ].
	aStream 
		nextPutAll: self namespace shortName asString; 
		nextPut: $:.
	super printOn: aStream. 
]

{ #category : #printing }
RDFShortNamedNode >> printShortOn: aStream [
	self value ifNil: [ ^ super printOn: aStream ].
	aStream nextPutAll: self value asString.
]
