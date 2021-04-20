Class {
	#name : #RDFList,
	#superclass : #RDFProtoObject,
	#instVars : [
		'collection',
		'store'
	],
	#category : #'ResourceDescriptionFramework-Core-Model'
}

{ #category : #accessing }
RDFList >> collection [
	^ collection
]

{ #category : #accessing }
RDFList >> collection: aCollection [
	collection := aCollection
]

{ #category : #accessing }
RDFList >> gtItemsFor: aView [
	<gtView>
	^ aView list
		title: 'Triples';
		items: [ self collection ];
		itemText: [ :aTriple | aTriple sentence ]
]

{ #category : #initialization }
RDFList >> initialize [
	super initialize.
	collection := OrderedCollection new.
]

{ #category : #accessing }
RDFList >> store [
	^ store
]

{ #category : #accessing }
RDFList >> store: anObject [
	store := anObject
]
