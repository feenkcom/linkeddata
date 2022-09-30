Class {
	#name : #RDFSimpleCollectionStore,
	#superclass : #RDFStore,
	#instVars : [
		'collection',
		'cachedSubjectsByIRI'
	],
	#category : #'ResourceDescriptionFramework-Core-Storage'
}

{ #category : #accessing }
RDFSimpleCollectionStore >> addPrefix: prefixName iri: aString [ 
	"Add the supplied prefix, ensuring that it matches an existing definition.
	Compatability with RDFJenaStore."

]

{ #category : #adding }
RDFSimpleCollectionStore >> addTriple: aRDFTriple [
	aRDFTriple store: self.
	self collection add: aRDFTriple.
	cachedSubjectsByIRI 
		at: aRDFTriple subject
		ifAbsentPut: [ 
			RDFExtractedSubject new 
				realObject: aRDFTriple subject;
				store: self ]
]

{ #category : #adding }
RDFSimpleCollectionStore >> addTriples: aCollectionOfRDFTriples [
	aCollectionOfRDFTriples do: [ :aRDFTriple | 
		self addTriple: aRDFTriple ]
]

{ #category : #accessing }
RDFSimpleCollectionStore >> collection [
	^ collection
]

{ #category : #enumerating }
RDFSimpleCollectionStore >> dataTypeObjects [
	<return: #Array of: #RDFExtracedSubject>
	
	| theTypeObjects |
	theTypeObjects := Set new. 
	self collection do: [ :aTriple | 
		aTriple predicate term = RDF type ifTrue: [ 
			theTypeObjects add: aTriple object ] ].
	^ theTypeObjects
	"^ theSubjects collect: [ :eachSubject | 
			RDFExtractedSubject new 
				realObject: eachSubject;
				store: self ]"
]

{ #category : #accessing }
RDFSimpleCollectionStore >> datasetUrl [ 

	^ #'memory://'
]

{ #category : #deleting }
RDFSimpleCollectionStore >> deleteWithSubject: aRdfSubject predicate: aRdfPredicate [

	collection := collection reject: 
		[ :each | each subject = aRdfSubject and: [ each predicate = aRdfPredicate ] ]
]

{ #category : #enumerating }
RDFSimpleCollectionStore >> do: doBlock [
	^ self collection do: doBlock
]

{ #category : #enumerating }
RDFSimpleCollectionStore >> extractedSubjects [
	<return: #Array of: #RDFExtracedSubject>
	^ cachedSubjectsByIRI values
	"| theSubjects |
	theSubjects := (self collection collect: #subject as: OrderedCollection) removeDuplicates.
	^ theSubjects collect: [ :eachSubject | 
			RDFExtractedSubject new 
				realObject: eachSubject;
				store: self ]"
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
	cachedSubjectsByIRI := Dictionary new.
]

{ #category : #accessing }
RDFSimpleCollectionStore >> maxBufferSize: aNumber [
	"Compatibility with RDFJenSotre"
]

{ #category : #querying }
RDFSimpleCollectionStore >> objectValuesWithSubject: aRDFSubject predicate: aRdfPredicate [
	<return: #Collection of: #RDFLiteral>

	^ collection 
		select: [ :triple | triple subject = aRDFSubject and: [ triple predicate = aRdfPredicate ] ]
		thenCollect: [ :triple | triple object term ]

]

{ #category : #accessing }
RDFSimpleCollectionStore >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPutAll: ' (';
		nextPutAll: self collection size asString;
		nextPutAll: ' triples';
		nextPutAll: ')'
]

{ #category : #enumerating }
RDFSimpleCollectionStore >> select: selectBlock thenCollect: collectBlock [
	^ self collection select: selectBlock thenCollect: collectBlock
]

{ #category : #enumerating }
RDFSimpleCollectionStore >> spheres [
	"<return: #RDFSpheres>"
	| spheres |
	spheres := RDFSpheres new store: self.
	self collection 
		inject: spheres collection
		into: [ :aList :eachTriple |
			(eachTriple predicate term = POLY sphere) ifTrue: [
				aList add: eachTriple ]. aList ].
	^ spheres 
]
