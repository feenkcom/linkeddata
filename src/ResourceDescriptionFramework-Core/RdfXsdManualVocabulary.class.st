Class {
	#name : #RdfXsdManualVocabulary,
	#superclass : #RdfManualVocabulary,
	#category : #'ResourceDescriptionFramework-Core-Importers'
}

{ #category : #adding }
RdfXsdManualVocabulary >> addToRdfResources [
	| resource |

	namespace := RdfNamespace new 
		name: 'xsd';
		iri: 'http://www.w3.org/2001/XMLSchema#'.
	#(string boolean decimal integer 
	double float
	date time dateTime dateTimeStamp
	gYear gMonth gDay gYearMonth gMonthDay duration yearMonthDuration dayTimeDuration
	byte short int long unsignedByte unsignedShort unsignedInt unsignedLong postitiveInteger nonNegativeInteger negativeInteger nonPositiveInteger
	hexBinary base64Binary
	anyURI language normalizedString token NMTOKEN Name NCName) do: [ :each |
		resource := RdfProperty new
			name: each;
			namespace: namespace.
		resources at: each put: resource ].
	RdfResources uniqueInstance
		add: namespace;
		addAll: resources.
]

{ #category : #initialization }
RdfXsdManualVocabulary >> initialize [

	super initialize.
	resources := Dictionary new.
]
