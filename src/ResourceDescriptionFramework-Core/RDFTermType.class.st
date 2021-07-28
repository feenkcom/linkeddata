Class {
	#name : 'RDFTermType',
	#superclass : 'Object',
	#classInstVars : [
		'uniqueInstance'
	],
	#category : 'ResourceDescriptionFramework-Core-Constants'
}

{ #category : 'factory' }
RDFTermType class >> blankNode [
	^ RDFBlankNodeTermType default
]

{ #category : 'cleanup' }
RDFTermType class >> cleanUniqueInstance [
	uniqueInstance := nil
]

{ #category : 'cleanup' }
RDFTermType class >> cleanUp [
	self cleanUniqueInstance
]

{ #category : 'accessing' }
RDFTermType class >> default [
	^ self uniqueInstance
]

{ #category : 'factory' }
RDFTermType class >> defaultGraph [
	^ RDFDefaultGraphTermType default
]

{ #category : 'factory' }
RDFTermType class >> literal [
	^ RDFLiteralTermType default
]

{ #category : 'factory' }
RDFTermType class >> namedNode [
	^ RDFNamedNodeTermType default
]

{ #category : 'accessing' }
RDFTermType class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : 'factory' }
RDFTermType class >> variable [
	^ RDFVariableTermType default
]

{ #category : 'evaluating' }
RDFTermType >> name [
	<return: #String>
	^ self subclassResponsibility
]
