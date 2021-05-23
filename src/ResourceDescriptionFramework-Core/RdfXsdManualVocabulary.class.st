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
	#(float time dateTimeStamp
	gYear gMonth gDay gYearMonth gMonthDay duration yearMonthDuration dayTimeDuration
	byte short int long unsignedByte unsignedShort unsignedInt unsignedLong postitiveInteger nonNegativeInteger negativeInteger nonPositiveInteger
	hexBinary base64Binary
	anyURI language normalizedString token NMTOKEN Name NCName) do: [ :each |
		resource := RdfProperty new
			name: each;
			namespace: namespace.
		resources at: each put: resource ].

	{	{ #boolean. [ :aString | RdfObjectValueParsers parseBoolean: aString ]. #yourself. }.
		{ #date. [ :aString | RdfObjectValueParsers parseDate: aString ]. #yourself. }.
		{ #dateTime. [ :aString | RdfObjectValueParsers parseDateTime: aString ]. #yourself. }.
		{ #decimal. [ :aString | RdfObjectValueParsers parseDecimal: aString ]. #yourself }.
		{ #double. [ :aString | RdfObjectValueParsers parseDouble: aString ]. #yourself. }.
		{ #integer. [ :aString | RdfObjectValueParsers parseInteger: aString ]. #yourself. } } do: [ :each |
		resource := RdfDataType new
			name: each first;
			namespace: namespace;
			parser: each second;
			printer: each third.
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
