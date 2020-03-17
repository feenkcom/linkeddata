Class {
	#name : #RDFResourceWithSphere,
	#superclass : #RDFResource,
	#instVars : [
		'sphere'
	],
	#category : #'ResourceDescriptionFramework-Examples'
}

{ #category : #simulation }
RDFResourceWithSphere >> gtViewsInContext: aContext [
	^ OrderedCollection new
		addAll: (self sphere gtSphereViewsFor: GtPhlowEmptyView new forTriples: self triples);
		addAll: (super gtViewsInContext: GtPhlowEmptyView new);
		yourself
]

{ #category : #accessing }
RDFResourceWithSphere >> sphere [
	^ sphere
]

{ #category : #accessing }
RDFResourceWithSphere >> sphere: anObject [
	sphere := anObject
]
