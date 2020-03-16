Class {
	#name : #RDFBasicFactory,
	#superclass : #Object,
	#traits : 'TGtAssert',
	#classTraits : 'TGtAssert classTrait',
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'ResourceDescriptionFramework-Core-Factories'
}

{ #category : #cleanup }
RDFBasicFactory class >> cleanUniqueInstance [
	^ uniqueInstance := nil
]

{ #category : #cleanup }
RDFBasicFactory class >> cleanUp [
	self cleanUniqueInstance
]

{ #category : #accessing }
RDFBasicFactory class >> default [
	^ self uniqueInstance
]

{ #category : #accessing }
RDFBasicFactory class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #factory }
RDFBasicFactory >> namedNode: aString [
	<return: #RDFNamedNode>
	self 
		assert: [ aString isString and: [ aString isNotEmpty ] ] 
		description: [ 'Named node value must be non empty string' ].
	^ RDFNamedNode new value: aString
]

{ #category : #factory }
RDFBasicFactory >> namedNodeSuffix: aString [
	<return: #RDFNamedNode>
	self 
		assert: [ aString isString and: [ aString isNotEmpty ] ] 
		description: [ 'Named node value must be non-empty string' ].
	^ self namedNode: self prefix, aString
]

{ #category : #factory }
RDFBasicFactory >> prefix [
	<return: #String>
	^ self subclassResponsibility
]
