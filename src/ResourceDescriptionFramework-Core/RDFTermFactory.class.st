Class {
	#name : #RDFTermFactory,
	#superclass : #RDFProtoFactory,
	#category : #'ResourceDescriptionFramework-Core-Factories'
}

{ #category : #factory }
RDFTermFactory >> namedNode: aString [
	<return: #RDFNamedNode>
	self 
		assert: [ aString isString and: [ aString isNotEmpty ] ] 
		description: [ 'Named node value must be non empty string' ].
	^ RDFNamedNode new value: aString
]

{ #category : #factory }
RDFTermFactory >> namedNodeSuffix: aString [
	<return: #RDFNamedNode>
	self 
		assert: [ aString isString and: [ aString isNotEmpty ] ] 
		description: [ 'Named node value must be non-empty string' ].
	^ self namedNode: self prefix, aString
]

{ #category : #factory }
RDFTermFactory >> prefix [
	<return: #String>
	^ self subclassResponsibility
]
