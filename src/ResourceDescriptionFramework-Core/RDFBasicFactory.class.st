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
