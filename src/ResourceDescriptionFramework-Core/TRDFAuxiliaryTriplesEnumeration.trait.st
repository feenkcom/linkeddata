Trait {
	#name : #TRDFAuxiliaryTriplesEnumeration,
	#category : #'ResourceDescriptionFramework-Core-Helpers'
}

{ #category : #accessing }
TRDFAuxiliaryTriplesEnumeration >> store [
	<return: #RDFStore>
	^ self explicitRequirement
]

{ #category : #accessing }
TRDFAuxiliaryTriplesEnumeration >> tripleSubject [
	<return: #RDFSubject>
	^ self explicitRequirement
]

{ #category : #accessing }
TRDFAuxiliaryTriplesEnumeration >> tripleSubjectTerm [
	<return: #RDFTerm>
	^ self tripleSubject term
]

{ #category : #enumerating }
TRDFAuxiliaryTriplesEnumeration >> triplesReferingToSubjectInto: aStream [
	self store
		do: [ :eachTriple | 
			eachTriple object term = self tripleSubjectTerm
				ifTrue: [ aStream
					nextPut:
						(RDFTripleRefereingToSubject new
							store: self store;
							realObject: eachTriple) ] ]
]

{ #category : #enumerating }
TRDFAuxiliaryTriplesEnumeration >> triplesWithSameSubjectInto: aStream [
	self store
		do: [ :eachTriple | 
			eachTriple subject = self tripleSubject
				ifTrue: [ aStream
						nextPut:
							(RDFTripleWithSameSubject new
								store: self store;
								realObject: eachTriple) ] ]
]
