Class {
	#name : #RDFTriples,
	#superclass : #RDFProtoObject,
	#instVars : [
		'collection',
		'store'
	],
	#category : #'ResourceDescriptionFramework-Core-Collections'
}

{ #category : #accessing }
RDFTriples >> collection [
	^ collection
]

{ #category : #accessing }
RDFTriples >> collection: anObject [
	collection := anObject
]

{ #category : #initialization }
RDFTriples >> defaultCollection [
	<return: #Collection>
	^ self subclassResponsibility
]

{ #category : #'gt-extension' }
RDFTriples >> gtCollectionFor: aView [
	<gtView>
	self collection ifNil: [ ^ aView empty ].
	^ aView list
		title: 'Collection';
		items: [ self collection ];
		itemFormat: [ :aTriple | aTriple sentence ]
]

{ #category : #initialization }
RDFTriples >> initialize [
	super initialize.
	collection := self defaultCollection.
]

{ #category : #accessing }
RDFTriples >> store [
	^ store
]

{ #category : #accessing }
RDFTriples >> store: anObject [
	store := anObject
]
