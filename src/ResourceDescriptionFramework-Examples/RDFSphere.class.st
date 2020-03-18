Class {
	#name : #RDFSphere,
	#superclass : #Object,
	#category : #'ResourceDescriptionFramework-Examples'
}

{ #category : #factory }
RDFSphere class >> ofName: aString [
	self allSubclassesDo: [ :eachClass | 
		eachClass sphereName = aString ifTrue: [ ^ eachClass default ] ].
	^ RDFUnknownSphere new name: aString
]

{ #category : #accessing }
RDFSphere class >> sphereName [
	^ self name
]

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
	<return: #String>
	^ self class sphereName
]
