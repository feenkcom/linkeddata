Extension { #name : 'ScaledDecimal' }

{ #category : '*ResourceDescriptionFramework-Core' }
ScaledDecimal >> printSparqlOn: aStream [

	self printOn: aStream showingDecimalPlaces: scale
]
