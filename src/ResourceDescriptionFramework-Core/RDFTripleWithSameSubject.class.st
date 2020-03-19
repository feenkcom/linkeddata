Class {
	#name : #RDFTripleWithSameSubject,
	#superclass : #RDFPreviewTriple,
	#category : #'ResourceDescriptionFramework-Core-Helpers'
}

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
