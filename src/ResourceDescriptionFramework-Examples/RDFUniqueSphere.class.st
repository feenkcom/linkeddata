Class {
	#name : #RDFUniqueSphere,
	#superclass : #RDFSphere,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'ResourceDescriptionFramework-Examples'
}

{ #category : #cleanup }
RDFUniqueSphere class >> cleanUniqueInstance [
	uniqueInstance := nil
]

{ #category : #cleanup }
RDFUniqueSphere class >> cleanUp [
	self cleanUniqueInstance
]

{ #category : #accessing }
RDFUniqueSphere class >> default [
	^ self uniqueInstance
]

{ #category : #accessing }
RDFUniqueSphere class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]
