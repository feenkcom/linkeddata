Class {
	#name : #RDFAuxiliaryObject,
	#superclass : #RDFProtoObject,
	#instVars : [
		'store',
		'realObject'
	],
	#category : #'ResourceDescriptionFramework-Core-Helpers'
}

{ #category : #accessing }
RDFAuxiliaryObject >> children [
	^ #()
]

{ #category : #'gt-extension' }
RDFAuxiliaryObject >> gtTriplesSubjectFor: aView [
	<gtView>
	self realObject ifNil: [ ^ aView empty ].
	^ aView tree
		title: 'Subjects';
		items: [ { self } ];
		children: [ :eachExtractedItem | eachExtractedItem children ]
]

{ #category : #simulation }
RDFAuxiliaryObject >> gtViewsInContext: aContext [
	^ OrderedCollection new
		addAll: (self realObject gtMainViewsInContext: GtPhlowEmptyView new);
		addAll: (super gtViewsInContext: GtPhlowEmptyView new);
		yourself
]

{ #category : #accessing }
RDFAuxiliaryObject >> realObject [
	^ realObject
]

{ #category : #accessing }
RDFAuxiliaryObject >> realObject: anObject [
	realObject := anObject
]

{ #category : #accessing }
RDFAuxiliaryObject >> store [
	^ store
]

{ #category : #accessing }
RDFAuxiliaryObject >> store: anObject [
	store := anObject
]
