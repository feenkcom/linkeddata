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
		title: 'Triples (sentence)';
		priority: 20;
		items: [ self collection ];
		itemText: [ :aTriple | aTriple sentence ]
]

{ #category : #'gt-extension' }
RDFSimpleCollectionStore >> gtTriplesSubjectFor: aView [
	<gtView>
	self collection ifNil: [ ^ aView empty ].
	^ aView tree
		title: 'Subjects';
		priority: 2;
		items: [ self extractedSubjects ];
		children: [ :eachExtractedItem | eachExtractedItem children ]
]

{ #category : #'gt-extension' }
RDFSimpleCollectionStore >> gtViewCollectionRawFor: aView [
	<gtView>
	self collection ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Triples (raw)';
		priority: 30;
		items: [ self collection ];
		column: 'Subject'
			item: #subject
			text: [ :aSubject | aSubject term fullNameWithDataType ];
		column: 'Predicate'
			item: #predicate
			text: [ :aPredicate | aPredicate term fullNameWithDataType ];
		column: 'Object'
			item: #object
			text: [ :anObject | anObject term fullNameWithDataType ]
]

{ #category : #'gt-extension' }
RDFSimpleCollectionStore >> gtViewCollectionSimpleFor: aView [
	<gtView>
	self collection ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Triples (basic)';
		priority: 25;
		items: [ self collection ];
		column: 'Subject' item: #subject;
		column: 'Predicate' item: #predicate;
		column: 'Object' item: #object
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
		subject: aSubject;
		sphere: aRDFSphere;
		triples: (self triplesForSubject: aSubject forSphere: aRDFSphere)
]

{ #category : #enumerating }
RDFSimpleCollectionStore >> select: selectBlock thenCollect: collectBlock [
	^ self collection select: selectBlock thenCollect: collectBlock
]

{ #category : #enumerating }
RDFSimpleCollectionStore >> spheres [
	<return: #RDFSpheres>
	| spheres |
	spheres := RDFSpheres new store: self.
	self collection 
		inject: spheres collection
		into: [ :aList :eachTriple |
			(eachTriple predicate term = POLY sphere) ifTrue: [
				aList add: eachTriple ]. aList ].
	^ spheres 
]

{ #category : #enumerating }
RDFSimpleCollectionStore >> triplesForPredicate: aPredicate [
	<return: #RDFList>

	^ RDFList new collection: (self collection 
		inject: OrderedCollection new
		into: [ :aList :eachTriple |
			(eachTriple predicate = aPredicate) ifTrue: [
				aList add: eachTriple ]. aList ])
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

{ #category : #enumerating }
RDFSimpleCollectionStore >> triplesForSubject: aSubject forSphere: aRDFSphere [
	<return: #RDFList>

	^ RDFList new collection: ((
		self triplesForSubject: aSubject) collection select: [ :aTriplet |
			aRDFSphere isInterestedInTriplet: aTriplet ])
]
