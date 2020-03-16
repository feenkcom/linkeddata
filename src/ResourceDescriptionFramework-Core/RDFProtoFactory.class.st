Class {
	#name : #RDFProtoFactory,
	#superclass : #Object,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'ResourceDescriptionFramework-Core-Factories'
}

{ #category : #cleanup }
RDFProtoFactory class >> cleanUniqueInstance [
	^ uniqueInstance := nil
]

{ #category : #cleanup }
RDFProtoFactory class >> cleanUp [
	self cleanUniqueInstance
]

{ #category : #accessing }
RDFProtoFactory class >> default [
	^ self uniqueInstance
]

{ #category : #accessing }
RDFProtoFactory class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]
