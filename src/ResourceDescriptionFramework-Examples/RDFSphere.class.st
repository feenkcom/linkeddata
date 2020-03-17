Class {
	#name : #RDFSphere,
	#superclass : #Object,
	#instVars : [
		'name'
	],
	#category : #'ResourceDescriptionFramework-Examples'
}

{ #category : #'as yet unclassified' }
RDFSphere >> gtSphereViewsFor: aView forTriples: aList [
	^ Array empty
	"^ GtPhlowViewsCollector new
		
		fromObject: self;
		context: aContext;
		collect."
]

{ #category : #accessing }
RDFSphere >> name [
	^ name
]

{ #category : #accessing }
RDFSphere >> name: anObject [
	name := anObject
]
