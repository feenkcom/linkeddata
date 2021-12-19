Class {
	#name : #RDFTermFactory,
	#superclass : #RDFProtoFactory,
	#instVars : [
		'namespace'
	],
	#category : 'ResourceDescriptionFramework-Core-Factories'
}

{ #category : #testing }
RDFTermFactory class >> isDynamic [
	"Answer a boolean indicating whether the receiver is a dynamic factory, i.e. doesn't have a fixed prefix and shortName.
	Most subclasses aren't dynamic, those that are should override this"

	^ false.
]

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

	^ self namedNodeSuffix: aString parser: nil
]

{ #category : #factory }
RDFTermFactory >> namedNodeSuffix: aString parser: aBlockClosure [
	<return: #RDFNamedNode>
	self 
		assert: [ aString isString and: [ aString isNotEmpty ] ] 
		description: [ 'Named node value must be non-empty string' ].
	^ self shortNamedNode 
		value: aString;
		parser: aBlockClosure
]

{ #category : #factory }
RDFTermFactory >> namespace [
	<return: #RDFNamespaceNamedNode>
	^ namespace ifNil: [ namespace := RDFNamespaceNamedNode new 
		value: self prefix;
		shortName: self shortName ]
]

{ #category : #factory }
RDFTermFactory >> prefix [
	"Note that the prefix must finish with a separator, typically / or #, so that name can be appended"
	<return: #String>
	^ self subclassResponsibility
]

{ #category : #factory }
RDFTermFactory >> shortName [
	<return: #String>
	^ self subclassResponsibility
]

{ #category : #factory }
RDFTermFactory >> shortNamedNode [
	<return: #RDFNamedNode>
	^ RDFShortNamedNode new namespace: self namespace
]
