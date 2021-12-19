Class {
	#name : #RDFPreviewObject,
	#superclass : #RDFProtoObject,
	#instVars : [
		'store',
		'realObject'
	],
	#category : 'ResourceDescriptionFramework-Core-Helpers'
}

{ #category : #accessing }
RDFPreviewObject >> children [
	^ #()
]

{ #category : #'gt-extension' }
RDFPreviewObject >> gtTriplesSubjectFor: aView [
	"<gtView>"
	self realObject ifNil: [ ^ aView empty ].
	^ aView tree
		title: 'Subjects';
		items: [ { self } ];
		children: [ :eachExtractedItem | eachExtractedItem children ]
]

{ #category : #simulation }
RDFPreviewObject >> gtViewsInContext: aContext [
	^ OrderedCollection new
		addAll: (self realObject gtMainViewsInContext: GtPhlowEmptyView new);
		addAll: (super gtViewsInContext: GtPhlowEmptyView new);
		yourself
]

{ #category : #accessing }
RDFPreviewObject >> realObject [
	^ realObject
]

{ #category : #accessing }
RDFPreviewObject >> realObject: anObject [
	realObject := anObject
]

{ #category : #accessing }
RDFPreviewObject >> store [
	^ store
]

{ #category : #accessing }
RDFPreviewObject >> store: anObject [
	store := anObject
]
