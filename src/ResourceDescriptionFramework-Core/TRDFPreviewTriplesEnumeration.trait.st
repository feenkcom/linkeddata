Trait {
	#name : 'TRDFPreviewTriplesEnumeration',
	#category : 'ResourceDescriptionFramework-Core-Helpers'
}

{ #category : 'accessing' }
TRDFPreviewTriplesEnumeration >> store [
	<return: #RDFStore>
	^ self explicitRequirement
]

{ #category : 'enumerating' }
TRDFPreviewTriplesEnumeration >> subjectsMentionedInTripleObjectInto: aStream [
	self store extractedSubjects
		do: [ :eachSubject | 
			eachSubject term = self tripleObjectTerm
				ifTrue: [ aStream nextPut: eachSubject ] ]
]

{ #category : 'accessing' }
TRDFPreviewTriplesEnumeration >> tripleObjectTerm [
	<return: #RDFTerm>
	^ self explicitRequirement
]

{ #category : 'accessing' }
TRDFPreviewTriplesEnumeration >> tripleSubject [
	<return: #RDFSubject>
	^ self explicitRequirement
]

{ #category : 'accessing' }
TRDFPreviewTriplesEnumeration >> tripleSubjectTerm [
	<return: #RDFTerm>
	^ self tripleSubject term
]

{ #category : 'enumerating' }
TRDFPreviewTriplesEnumeration >> triplesReferingToSubjectInto: aStream [
	self store
		do: [ :eachTriple | 
			eachTriple object term = self tripleSubjectTerm
				ifTrue: [ aStream
					nextPut:
						(RDFTripleRefereingToSubject new
							store: self store;
							realObject: eachTriple) ] ]
]

{ #category : 'enumerating' }
TRDFPreviewTriplesEnumeration >> triplesWithSameSubjectInto: aStream [
	self store
		do: [ :eachTriple | 
			eachTriple subject = self tripleSubject
				ifTrue: [ aStream
						nextPut:
							(RDFTripleWithSameSubject new
								store: self store;
								realObject: eachTriple) ] ]
]
