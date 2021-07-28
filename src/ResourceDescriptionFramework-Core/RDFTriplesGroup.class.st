Class {
	#name : 'RDFTriplesGroup',
	#superclass : 'RDFTriples',
	#category : 'ResourceDescriptionFramework-Core-Collections'
}

{ #category : 'initialization' }
RDFTriplesGroup >> defaultCollection [
	^ OrderedCollection new
]

{ #category : 'enumerating' }
RDFTriplesGroup >> do: aBlock [ 
	self collection do: aBlock 
]

{ #category : 'accessing' }
RDFTriplesGroup >> first [ 
	^ self collection first
]
