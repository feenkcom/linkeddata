Extension { #name : 'Date' }

{ #category : '*ResourceDescriptionFramework-Core' }
Date >> printSparqlOn: aStream [

	self asDateAndTime printSparqlOn: aStream
]
