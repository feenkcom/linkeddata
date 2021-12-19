Class {
	#name : #RDFTripleWithSameSubject,
	#superclass : #RDFPreviewTriple,
	#traits : 'TRDFPreviewTriplesEnumeration - {#store}',
	#classTraits : 'TRDFPreviewTriplesEnumeration classTrait',
	#category : 'ResourceDescriptionFramework-Core-Helpers'
}

{ #category : #accessing }
RDFTripleWithSameSubject >> children [
	^ OrderedCollection
		streamContents: [ :aStream | 
			"self triplesWithSameSubjectInto: aStream."
			"self subjectsMentionedInTripleObjectInto: aStream."
			"self triplesReferingToSubjectInto: aStream." ]
]

{ #category : #printing }
RDFTripleWithSameSubject >> printOn: aStream [
	self realObject ifNil: [ ^ super printOn: aStream ].
	self printSentenceOn: aStream
]

{ #category : #printing }
RDFTripleWithSameSubject >> printSentenceOn: aStream [
	self predicate ifNotNil: [ :aPredicate | 
		aStream nextPutAll: 'has a '; print: aPredicate ].
	self object ifNotNil: [ :anObject | 
		aStream nextPutAll: ' whose value is '; print: anObject; nextPut: $. ].
]

{ #category : #accessing }
RDFTripleWithSameSubject >> tripleObjectTerm [
	<return: #RDFTerm>
	^ self realObject object term
]

{ #category : #accessing }
RDFTripleWithSameSubject >> tripleSubject [
	<return: #RDFSubject>
	^ self realObject subject
]
