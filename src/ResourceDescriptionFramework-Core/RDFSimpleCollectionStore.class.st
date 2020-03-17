Class {
	#name : #RDFSimpleCollectionStore,
	#superclass : #RDFStore,
	#instVars : [
		'collection'
	],
	#category : #'ResourceDescriptionFramework-Core-Storage'
}

{ #category : #adding }
RDFSimpleCollectionStore >> addTriple: aRDFTriple [
	self collection add: aRDFTriple
]

{ #category : #accessing }
RDFSimpleCollectionStore >> collection [
	^ collection
]

{ #category : #'gt-extension' }
RDFSimpleCollectionStore >> gtCollectionFor: aView [
	<gtView>
	self collection ifNil: [ ^ aView empty ].
	^ aView list
		title: 'Collection';
		items: [ self collection ];
		itemFormat: [ :aTriple | aTriple sentence ]
]

{ #category : #initialization }
RDFSimpleCollectionStore >> initialize [
	super initialize.
	collection := OrderedCollection new.
]
