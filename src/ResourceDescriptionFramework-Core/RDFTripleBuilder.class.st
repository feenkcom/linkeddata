Class {
	#name : #RDFTripleBuilder,
	#superclass : #RDFProtoBuilder,
	#instVars : [
		'triple',
		'subject',
		'predicate',
		'object'
	],
	#category : #'ResourceDescriptionFramework-Core-Builders'
}

{ #category : #'building - object' }
RDFTripleBuilder >> build [

	self assert: subject isSubject.
	self assert: predicate isPredicate.
	self assert: object isObject.

	^ RDFTriple new
		subject: subject;
		predicate: predicate;
		object: object
]

{ #category : #accessing }
RDFTripleBuilder >> object [
	^ object
]

{ #category : #'building - object' }
RDFTripleBuilder >> object: aRdfObject [
	self 
		assert: [ aRdfObject isNotNil ] 
		description: [ 'Object must be non-nil' ].
	object := aRdfObject.
]

{ #category : #'building - object' }
RDFTripleBuilder >> objectIRI: aString [
	| aTerm |
	self 
		assert: [ aString isString and: [ aString isNotEmpty ] ] 
		description: [ 'Object IRI must be non-empty string' ].
	aTerm := RDF namedNode: aString.
	self objectTerm: aTerm.
]

{ #category : #'building - subject' }
RDFTripleBuilder >> objectJSONDictionary: aDictionary [
	"Set the triple's object based on the dictionary returned by the SPARQL server"
	| type |

	"Parsing the type is better left to the parser.
	Until that's available, handle a few basic types locally"
	type := aDictionary at: #type.
	(#(literal uri) includes: type) ifTrue:
		[ ^ self objectTerm: (RDF namedNode: (aDictionary at: #value)) ].
	self error: 'Unknown object type'.

]

{ #category : #'building - object' }
RDFTripleBuilder >> objectLiteral: aString [
	| aTerm |
	self 
		assert: [ aString isString and: [ aString isNotEmpty ] ] 
		description: [ 'Object literal must be non-empty string' ].
	aTerm := RDF literal: aString.
	^ self objectTerm: aTerm.
]

{ #category : #'building - object' }
RDFTripleBuilder >> objectLiteral: aValue type: aType [
	| aTerm |
	aTerm := RDF literal: aValue type: aType.
	^ self objectTerm: aTerm.
]

{ #category : #'building - object' }
RDFTripleBuilder >> objectNTerm: aString [ 
	"Build the object assuming the type from the encoding.
	This is a hack - the type should be determined by looking up the predicate schema and parsing based on that information.
	Assume type based on first character:
	- iso8601 regex -> date (must be UTC)
	- greater-than -> IRI
	- true or false -> boolean
	- digit -> number
	- double-quote -> string"

	(DateAndTime gtIsISO8601: aString) ifTrue: 
		[ ^ self objectLiteral: (DateAndTime readFrom: aString readStream) type: XSD date ].
	(aString first = $<) ifTrue: 
		[ ^ self objectLiteral: (aString copyFrom: 2 to: aString size - 1) ].
	(aString = 'true' or: [ aString = 'false' ]) ifTrue: 
		[ ^ self objectLiteral: aString = 'true' type: XSD boolean ].
	aString first isDigit ifTrue: 
		[ ^ (aString indexOf: $.) > 0
			ifTrue: [ self objectLiteral: aString asNumber type: XSD decimal ]
			ifFalse: [ self objectLiteral: aString asNumber type: XSD integer ] ].
	aString first = $" ifTrue: 
		[ ^ self objectLiteral: (aString copyFrom: 2 to: aString size - 1) type: XSD string ].
	self error: 'Unknown N-Type'.
]

{ #category : #'building - object' }
RDFTripleBuilder >> objectNamespace: aNamespace suffix: aSuffixString [
	| aTerm |
	aTerm := RDF namedNode: aSuffixString inNamespace: aNamespace.
	self objectTerm: aTerm
]

{ #category : #'building - object' }
RDFTripleBuilder >> objectNamespaceIRI: aNamespaceString as: aShortNameString suffix: aSuffixString [
	| aNamespace |
	aNamespace := RDF namespaceValue: aNamespaceString shortName: aShortNameString.
	self objectNamespace: aNamespace suffix: aSuffixString.
]

{ #category : #'building - object' }
RDFTripleBuilder >> objectTerm: aTerm [

	self 
		assert: [ aTerm isNotNil ] 
		description: [ 'Object term must be non-nil' ].
	^ object := RDF object: aTerm.

]

{ #category : #'building - object' }
RDFTripleBuilder >> objectValue: anObject [
	"Build the object based on the objects class.  Note that IRI's should be added with objectIRI:
	Assume type based on first character:
	- DateAndTime -> date
	- Boolean -> boolean
	- Float, ScaledDecimal, Fraction -> number
	- String -> string"

	anObject isString ifTrue:
		[ ^ self objectLiteral: anObject type: XSD string ].
	anObject isBoolean ifTrue: 
		[ ^ self objectLiteral: anObject type: XSD boolean ].
	anObject isInteger ifTrue: 
		[ ^ self objectLiteral: anObject type: XSD integer ].
	anObject isNumber ifTrue:
		[ ^ self objectLiteral: anObject asFloat type: XSD decimal ].
	(anObject isKindOf: DateAndTime) ifTrue: 
		[ ^ self objectLiteral: anObject asUTC type: XSD date ].

	self error: 'Unknown object type'.
]

{ #category : #accessing }
RDFTripleBuilder >> predicate [
	^ predicate
]

{ #category : #'building - predicate' }
RDFTripleBuilder >> predicate: aPredicate [
	self 
		assert: [ aPredicate isNotNil ] 
		description: [ 'Predicate must be non-nil' ].
	predicate := aPredicate.
]

{ #category : #'building - predicate' }
RDFTripleBuilder >> predicateIRI: aString [
	| aTerm |
	self 
		assert: [ aString isString and: [ aString isNotEmpty ] ] 
		description: [ 'Predicate IRI must be non-empty string' ].
	aTerm := RDF namedNode: aString.
	self predicateTerm: aTerm.
]

{ #category : #'building - predicate' }
RDFTripleBuilder >> predicateNamespace: aNamespace suffix: aSuffixString [
	| aTerm |
	aTerm := RDF namedNode: aSuffixString inNamespace: aNamespace.
	self predicateTerm: aTerm
]

{ #category : #'building - predicate' }
RDFTripleBuilder >> predicateNamespaceIRI: aNamespaceString as: aShortNameString suffix: aSuffixString [
	| aNamespace |
	aNamespace := RDF namespaceValue: aNamespaceString shortName: aShortNameString.
	self predicateNamespace: aNamespace suffix: aSuffixString.
]

{ #category : #'building - predicate' }
RDFTripleBuilder >> predicateTerm: aTerm [
	| aPredicate |
	self 
		assert: [ aTerm isNotNil ] 
		description: [ 'Predicate term must be non-nil' ].
	aPredicate := RDF predicate: aTerm.
	self predicate: aPredicate.
]

{ #category : #accessing }
RDFTripleBuilder >> subject [
	^ subject
]

{ #category : #'building - subject' }
RDFTripleBuilder >> subject: aSubject [
	self 
		assert: [ aSubject isNotNil ] 
		description: [ 'Subject must be non-nil' ].
	^ subject := aSubject.
]

{ #category : #'building - subject' }
RDFTripleBuilder >> subjectIRI: aString [
	| aTerm |
	self 
		assert: [ aString isString and: [ aString isNotEmpty ] ] 
		description: [ 'Subject IRI must be non-empty string' ].
	aTerm := RDF namedNode: aString.
	^ self subjectTerm: aTerm.
]

{ #category : #'building - subject' }
RDFTripleBuilder >> subjectJSONDictionary: aDictionary [

	self assert: (aDictionary at: #type) equals: #uri.
	self subjectTerm: (RDF namedNode: (aDictionary at: #value)).
]

{ #category : #'building - subject' }
RDFTripleBuilder >> subjectTerm: aTerm [
	| aSubject |
	self 
		assert: [ aTerm isNotNil ] 
		description: [ 'Subject term must be non-nil' ].
	aSubject := RDF subject: aTerm.
	^ self subject: aSubject.
]

{ #category : #accessing }
RDFTripleBuilder >> triple [

	^ self build
]
