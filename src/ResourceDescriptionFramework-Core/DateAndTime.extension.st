Extension { #name : 'DateAndTime' }

{ #category : '*ResourceDescriptionFramework-Core' }
DateAndTime >> printSparqlOn: aStream [

	aStream
		nextPut: $";
		<< self asIso8601;
		<< '"^^xsd:dateTime' 
]
