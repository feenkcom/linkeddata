Extension { #name : #String }

{ #category : #'*ResourceDescriptionFramework-Core' }
String >> printSparqlOn: aStream [

	aStream 
		<< '"""';
		<< (self copyReplaceAll: '"' with: '\"');
		<< '"""'
]
