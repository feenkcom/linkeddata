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
	aRDFTriple store: self.
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

{ #category : #'gt-extension' }
RDFSimpleCollectionStore >> gtSpheresFor: aView [
	<gtView>
	self collection ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Spheres';
		priority: 1;
		object: [ self spheres ];
		view: #gtSpheresFor:
]

{ #category : #initialization }
RDFSimpleCollectionStore >> initialize [
	super initialize.
	collection := OrderedCollection new.
]

{ #category : #enumerating }
RDFSimpleCollectionStore >> resourceForSubject: aSubject withSphere: aRDFSphere [
	<return: #RDFResourceWithSphere>

	^ RDFResourceWithSphere new 
		sphere: aRDFSphere;
		triples: (self triplesForSubject: aSubject)
]

{ #category : #enumerating }
RDFSimpleCollectionStore >> spheres [
	<return: #RDFSpheres>
	| aCollection |
	aCollection := RDFSpheres new store: self.
	self collection 
		inject: aCollection collection
		into: [ :aList :eachTriple |
			(eachTriple predicate term = POLY sphere) ifTrue: [
				aList add: eachTriple ]. aList ].
	^ aCollection 
]

{ #category : #enumerating }
RDFSimpleCollectionStore >> triplesForSubject: aSubject [
	<return: #RDFList>

	^ RDFList new collection: (self collection 
		inject: OrderedCollection new
		into: [ :aList :eachTriple |
			(eachTriple subject = aSubject) ifTrue: [
				aList add: eachTriple ]. aList ])
]