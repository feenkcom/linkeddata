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

{ #category : #enumerating }
RDFSimpleCollectionStore >> do: doBlock [
	^ self collection do: doBlock
]

{ #category : #enumerating }
RDFSimpleCollectionStore >> extractedSubjects [
	<return: #Array of: #RDFExtracedSubject>
	| theSubjects |
	theSubjects := (self collection collect: #subject as: OrderedCollection) removeDuplicates.
	^ theSubjects collect: [ :eachSubject | 
			RDFExtractedSubject new 
				realObject: eachSubject;
				store: self ]
]

{ #category : #'gt-extension' }
RDFSimpleCollectionStore >> gtCollectionFor: aView [
	<gtView>
	self collection ifNil: [ ^ aView empty ].
	^ aView list
		title: 'Triples';
		items: [ self collection ];
		itemFormat: [ :aTriple | aTriple sentence ]
]

{ #category : #'gt-extension' }
RDFSimpleCollectionStore >> gtTriplesSubjectFor: aView [
	<gtView>
	self collection ifNil: [ ^ aView empty ].
	^ aView tree
		title: 'Subjects';
		items: [ self extractedSubjects ];
		children: [ :eachExtractedItem | eachExtractedItem children ]
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
RDFSimpleCollectionStore >> select: selectBlock thenCollect: collectBlock [
	^ self collection select: selectBlock thenCollect: collectBlock
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
