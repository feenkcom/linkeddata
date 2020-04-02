Class {
	#name : #RDFSimpleCollectionFeatureViewsStore,
	#superclass : #RDFStore,
	#traits : 'TSRFFeatureRemoteViewBuilder',
	#classTraits : 'TSRFFeatureRemoteViewBuilder classTrait',
	#instVars : [
		'collection'
	],
	#category : #'ResourceDescriptionFramework-Core-Storage'
}

{ #category : #adding }
RDFSimpleCollectionFeatureViewsStore >> addTriple: aRDFTriple [
	aRDFTriple store: self.
	self collection add: aRDFTriple
]

{ #category : #accessing }
RDFSimpleCollectionFeatureViewsStore >> collection [
	^ collection
]

{ #category : #enumerating }
RDFSimpleCollectionFeatureViewsStore >> do: doBlock [
	^ self collection do: doBlock
]

{ #category : #enumerating }
RDFSimpleCollectionFeatureViewsStore >> extractedSubjects [
	<return: #Array of: #RDFExtracedSubject>
	| theSubjects |
	theSubjects := (self collection collect: #subject as: OrderedCollection) removeDuplicates.
	^ theSubjects collect: [ :eachSubject | 
			RDFExtractedSubject new 
				realObject: eachSubject;
				store: self ]
]

{ #category : #private }
RDFSimpleCollectionFeatureViewsStore >> getJsObjectCode [
	^ 'let sopod = require(''sopod'');
new sopod.SoGenericTriplesViewer();'
]

{ #category : #'gt-extension' }
RDFSimpleCollectionFeatureViewsStore >> gtCollectionFor: aView [
	<gtView>
	self collection ifNil: [ ^ aView empty ].
	^ aView explicit 
		title: 'Triples (sentence)-F';
		priority: 1;
		stencil: [ (self getSerialisableViewForId: 'gtSerialisableTripletsSentenceList')
			asElementDo: [ :anElement | anElement ] ]
]

{ #category : #'gt-extension' }
RDFSimpleCollectionFeatureViewsStore >> gtTriplesSubjectFor: aView [
	"<gtView>"
	self collection ifNil: [ ^ aView empty ].
	^ aView tree
		title: 'Subjects';
		priority: 2;
		items: [ self extractedSubjects ];
		children: [ :eachExtractedItem | eachExtractedItem children ]
]

{ #category : #'gt-extension' }
RDFSimpleCollectionFeatureViewsStore >> gtViewCollectionRawFor: aView [
	"<gtView>"
	self collection ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Triples (raw)';
		priority: 30;
		items: [ self collection ];
		column: 'Subject' 
			item: #subject
			format: [ :aSubject | aSubject term fullNameWithDataType ];
		column: 'Predicate' 
			item: #predicate
			format: [ :aPredicate | aPredicate term fullNameWithDataType ];
		column: 'Object' 
			item: #object
			format: [ :anObject | anObject term fullNameWithDataType ]
]

{ #category : #'gt-extension' }
RDFSimpleCollectionFeatureViewsStore >> gtViewCollectionSimpleFor: aView [
	"<gtView>"
	self collection ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Triples (basic)';
		priority: 25;
		items: [ self collection ];
		column: 'Subject' item: #subject;
		column: 'Predicate' item: #predicate;
		column: 'Object' item: #object
]

{ #category : #'gt-extension' }
RDFSimpleCollectionFeatureViewsStore >> gtViewCookiesNamesViewFor: aView [
	<gtView>
	self collection ifNil: [ ^ aView empty ].
	^ aView explicit 
		title: 'Cookies names-F';
		priority: 200;
		stencil: [ (self getSerialisableViewForId: 'gtSerialisableCookiesList')
			asElementDo: [ :anElement | anElement ] ]
]

{ #category : #initialization }
RDFSimpleCollectionFeatureViewsStore >> initialize [
	super initialize.
	collection := OrderedCollection new.
]

{ #category : #enumerating }
RDFSimpleCollectionFeatureViewsStore >> resourceForSubject: aSubject withSphere: aRDFSphere [
	<return: #RDFResourceWithSphere>
	
	^ RDFResourceWithSphere new 
		subject: aSubject;
		sphere: aRDFSphere;
		triples: (self triplesForSubject: aSubject forSphere: aRDFSphere)
]

{ #category : #enumerating }
RDFSimpleCollectionFeatureViewsStore >> select: selectBlock thenCollect: collectBlock [
	^ self collection select: selectBlock thenCollect: collectBlock
]

{ #category : #enumerating }
RDFSimpleCollectionFeatureViewsStore >> spheres [
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
RDFSimpleCollectionFeatureViewsStore >> triplesForPredicate: aPredicate [
	<return: #RDFList>

	^ RDFList new collection: (self collection 
		inject: OrderedCollection new
		into: [ :aList :eachTriple |
			(eachTriple predicate = aPredicate) ifTrue: [
				aList add: eachTriple ]. aList ])
]

{ #category : #enumerating }
RDFSimpleCollectionFeatureViewsStore >> triplesForSubject: aSubject [
	<return: #RDFList>

	^ RDFList new collection: (self collection 
		inject: OrderedCollection new
		into: [ :aList :eachTriple |
			(eachTriple subject = aSubject) ifTrue: [
				aList add: eachTriple ]. aList ])
]

{ #category : #enumerating }
RDFSimpleCollectionFeatureViewsStore >> triplesForSubject: aSubject forSphere: aRDFSphere [
	<return: #RDFList>

	^ RDFList new collection: ((
		self triplesForSubject: aSubject) collection select: [ :aTriplet |
			aRDFSphere isInterestedInTriplet: aTriplet ])
]