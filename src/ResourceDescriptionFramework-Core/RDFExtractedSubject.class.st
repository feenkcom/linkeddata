Class {
	#name : #RDFExtractedSubject,
	#superclass : #RDFPreviewObject,
	#traits : 'TRDFPreviewTriplesEnumeration - {#store}',
	#classTraits : 'TRDFPreviewTriplesEnumeration classTrait',
	#category : #'ResourceDescriptionFramework-Core-Helpers'
}

{ #category : #accessing }
RDFExtractedSubject >> children [
	^ OrderedCollection
		streamContents: [ :aStream | 
			self triplesWithSameSubjectInto: aStream ]
]

{ #category : #'gt-extensions' }
RDFExtractedSubject >> gtViewSpheresFor: aView [
	<gtView>
	^ aView list
		title: 'Spheres';
		priority: 20;
		items: [ self sphereTriples ];
		itemText: #object;
		send: [ :aSphereTriplet | 
			| targetSphere |
			
			targetSphere := RDFSphere ofName: aSphereTriplet object term value.
			RDFResourceWithSphere new 
				subject: aSphereTriplet subject;
				sphere: targetSphere;
				triples: (self store 
					triplesForSubject: aSphereTriplet subject
					forSphere: targetSphere);
				yourself  ]
]

{ #category : #'gt-extensions' }
RDFExtractedSubject >> gtViewTriplesFor: aView [ 
	<gtView>
	^ aView columnedList
		title: 'Triples';
		priority: -10;
		items: [ self children ];
		column: 'Subject' item: #subject;
		column: 'Predicate' item: #predicate;
		column: 'Object' item: #object
]

{ #category : #printing }
RDFExtractedSubject >> printOn: aStream [
	self realObject ifNil: [ ^ super printOn: aStream ].
	aStream print: self realObject
]

{ #category : #accessing }
RDFExtractedSubject >> sphereTriples [
	^ self children select: [ :aTriple |
		aTriple predicate term = POLY sphere ]
]

{ #category : #accessing }
RDFExtractedSubject >> term [
	<return: #RDFTerm>
	^ self realObject term
]

{ #category : #accessing }
RDFExtractedSubject >> tripleSubject [
	<return: #RDFStore>
	^ self realObject
]
