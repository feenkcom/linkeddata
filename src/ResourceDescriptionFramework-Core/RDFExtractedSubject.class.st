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
			self triplesWithSameSubjectInto: aStream.
			self triplesReferingToSubjectInto: aStream. ]
]

{ #category : #printing }
RDFExtractedSubject >> printOn: aStream [
	self realObject ifNil: [ ^ super printOn: aStream ].
	aStream print: self realObject
]

{ #category : #accessing }
RDFExtractedSubject >> tripleSubject [
	<return: #RDFStore>
	^ self realObject
]
