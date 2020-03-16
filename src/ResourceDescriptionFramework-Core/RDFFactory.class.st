Class {
	#name : #RDFFactory,
	#superclass : #RDFBasicFactory,
	#category : #'ResourceDescriptionFramework-Core-Factories'
}

{ #category : #factory }
RDFFactory >> namedNode: aString [
	<return: #RDFNamedNode>
	self 
		assert: [ aString isString and: [ aString isNotEmpty ] ] 
		description: [ 'Named node value must be non empty string' ].
	^ RDFNamedNode new value: aString
]

{ #category : #accessing }
RDFFactory >> string [
	<return: #RDFNamedNode>
	^ self namedNode: 'http://www.w3.org/2001/XMLSchema#string'
]
