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
RDFShortNamedNode >> printDescriptionOn: aStream [
	aStream nextPutAll: 'Short name: '.
	self printShortNameOn: aStream.
	aStream cr; nextPutAll: ' Full name: '.
	self printFullNameOn: aStream
]

{ #category : #accessing }
RDFShortNamedNode >> printFullNameOn: aStream [
	self namespace ifNil: [ ^ self printOn: aStream ].
	self namespace printFullNameOn: aStream.
	self printOn: aStream
]

{ #category : #printing }
RDFShortNamedNode >> printFullNameWithDataTypeOn: aStream [
	self namespace ifNil: [ ^ self printOn: aStream ].
	self namespace printFullNameWithDataTypeOn: aStream.
	self printOn: aStream
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
RDFShortNamedNode >> printShortNameOn: aStream [
	self value ifNil: [ ^ super printOn: aStream ].
	aStream nextPutAll: self value asString.
]
