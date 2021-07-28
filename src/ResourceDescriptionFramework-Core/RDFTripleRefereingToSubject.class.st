Class {
	#name : 'RDFTripleRefereingToSubject',
	#superclass : 'RDFPreviewTriple',
	#traits : 'TRDFPreviewTriplesEnumeration - {#store}',
	#classTraits : 'TRDFPreviewTriplesEnumeration classTrait',
	#category : 'ResourceDescriptionFramework-Core-Helpers'
}

{ #category : 'accessing' }
RDFTripleRefereingToSubject >> children [
	^ OrderedCollection
		streamContents: [ :aStream | 
			self triplesWithSameSubjectInto: aStream.
			self triplesReferingToSubjectInto: aStream. ]
]

{ #category : 'printing' }
RDFTripleRefereingToSubject >> printOn: aStream [
	self realObject ifNil: [ ^ super printOn: aStream ].
	self printSentenceOn: aStream
]

{ #category : 'printing' }
RDFTripleRefereingToSubject >> printSentenceOn: aStream [
	self predicate ifNotNil: [ :aPredicate | 
		aStream nextPutAll: 'is a '; print: aPredicate ].
	self subject ifNotNil: [ :aSubject | 
		aStream nextPutAll: ' of '; print: aSubject; nextPut: $. ].
]

{ #category : 'accessing' }
RDFTripleRefereingToSubject >> tripleSubject [
	<return: #RDFStore>
	^ self realObject subject
]
