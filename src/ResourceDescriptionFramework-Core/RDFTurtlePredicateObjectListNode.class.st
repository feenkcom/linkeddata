Class {
	#name : #RDFTurtlePredicateObjectListNode,
	#superclass : #RDFTurtleDocumentNode,
	#instVars : [
		'verbs',
		'objectLists'
	],
	#category : 'ResourceDescriptionFramework-Core-Parsers'
}

{ #category : #generated }
RDFTurtlePredicateObjectListNode >> acceptVisitor: aDocumentVisitor [
	^ aDocumentVisitor visitPredicateObjectList: self
]

{ #category : #generated }
RDFTurtlePredicateObjectListNode >> compositeNodeVariables [
	^ #(#verbs #objectLists)
]

{ #category : #'generated-initialize-release' }
RDFTurtlePredicateObjectListNode >> initialize [
	super initialize.
	verbs := OrderedCollection new: 2.
	objectLists := OrderedCollection new: 2.
]

{ #category : #generated }
RDFTurtlePredicateObjectListNode >> objectLists [
	^ objectLists
]

{ #category : #generated }
RDFTurtlePredicateObjectListNode >> objectLists: anOrderedCollection [
	self setParents: self objectLists to: nil.
	objectLists := anOrderedCollection.
	self setParents: self objectLists to: self
]

{ #category : #generated }
RDFTurtlePredicateObjectListNode >> verbs [
	^ verbs
]

{ #category : #generated }
RDFTurtlePredicateObjectListNode >> verbs: anOrderedCollection [
	self setParents: self verbs to: nil.
	verbs := anOrderedCollection.
	self setParents: self verbs to: self
]
