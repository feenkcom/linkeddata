Class {
	#name : #RDFTripleBuilder,
	#superclass : #RDFProtoBuilder,
	#instVars : [
		'triple'
	],
	#category : #'ResourceDescriptionFramework-Core-Builders'
}

{ #category : #'building - object' }
RDFTripleBuilder >> build [
	^ self triple
]

{ #category : #initialization }
RDFTripleBuilder >> defaultTriple [
	^ RDF triple
]

{ #category : #initialization }
RDFTripleBuilder >> initialize [
	super initialize.
	triple := self defaultTriple.
]

{ #category : #'building - object' }
RDFTripleBuilder >> object: anObject [
	self 
		assert: [ anObject isNotNil ] 
		description: [ 'Object must be non-nil' ].
	self triple object: anObject.
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

{ #category : #'building - object' }
RDFTripleBuilder >> objectLiteral: aString [
	| aTerm |
	self 
		assert: [ aString isString and: [ aString isNotEmpty ] ] 
		description: [ 'Object literal must be non-empty string' ].
	aTerm := RDF literal: aString.
	self objectTerm: aTerm.
]

{ #category : #'building - object' }
RDFTripleBuilder >> objectLiteral: aValue type: aType [
	| aTerm |
	aTerm := RDF literal: aValue type: XSD date.
	self objectTerm: aTerm.
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
	| anObject |
	self 
		assert: [ aTerm isNotNil ] 
		description: [ 'Object term must be non-nil' ].
	anObject := RDF subject: aTerm.
	self object: anObject.
]

{ #category : #'building - predicate' }
RDFTripleBuilder >> predicate: aPredicate [
	self 
		assert: [ aPredicate isNotNil ] 
		description: [ 'Predicate must be non-nil' ].
	self triple predicate: aPredicate.
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

{ #category : #'building - subject' }
RDFTripleBuilder >> subject: aSubject [
	self 
		assert: [ aSubject isNotNil ] 
		description: [ 'Subject must be non-nil' ].
	self triple subject: aSubject.
]

{ #category : #'building - subject' }
RDFTripleBuilder >> subjectIRI: aString [
	| aTerm |
	self 
		assert: [ aString isString and: [ aString isNotEmpty ] ] 
		description: [ 'Subject IRI must be non-empty string' ].
	aTerm := RDF namedNode: aString.
	self subjectTerm: aTerm.
]

{ #category : #'building - subject' }
RDFTripleBuilder >> subjectTerm: aTerm [
	| aSubject |
	self 
		assert: [ aTerm isNotNil ] 
		description: [ 'Subject term must be non-nil' ].
	aSubject := RDF subject: aTerm.
	self subject: aSubject.
]

{ #category : #accessing }
RDFTripleBuilder >> triple [
	^ triple
]

{ #category : #accessing }
RDFTripleBuilder >> triple: anObject [
	triple := anObject
]
