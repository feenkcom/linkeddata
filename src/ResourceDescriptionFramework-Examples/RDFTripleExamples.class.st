Class {
	#name : #RDFTripleExamples,
	#superclass : #Object,
	#traits : 'TRDFExamples',
	#classTraits : 'TRDFExamples classTrait',
	#category : #'ResourceDescriptionFramework-Examples'
}

{ #category : #'examples - empty objects' }
RDFTripleExamples >> emptyLanguage [
	<gtExample>
	| aLanguage |
	aLanguage := RDFLanguage new.
	self assert: aLanguage tags size equals: 1.
	self assert: aLanguage tags equals: #( 'en' ).
	self assert: aLanguage printString equals: 'en'.
	^ aLanguage
]

{ #category : #'examples - empty objects' }
RDFTripleExamples >> emptyLiteral [
	<gtExample>
	| aLiteral |
	aLiteral := RDFLiteral new.
	self assert: aLiteral value isNil.
	^ aLiteral
]

{ #category : #'examples - empty objects' }
RDFTripleExamples >> emptyTriple [
	<gtExample>
	| aTriple |
	aTriple := RDFTriple new.
	self assert: aTriple subject isNil.
	^ aTriple
]

{ #category : #'examples - basic' }
RDFTripleExamples >> englishLanguage [
	<gtExample>
	| aLanguage |
	aLanguage := RDF language en.
	self assert: aLanguage tags size equals: 1.
	self assert: aLanguage tags equals: #( 'en' ).
	self assert: aLanguage printString equals: 'en'.
	^ aLanguage	
]

{ #category : #'examples - Tim Berners-Lee' }
RDFTripleExamples >> givenNamePredicate [
	<gtExample>
	| aPredicate |
	aPredicate := self predicateWith: FOAF givenName.
	self assert: (aPredicate term value endsWith: 'givenName').
	^ aPredicate.
]

{ #category : #'examples - Tim Berners-Lee' }
RDFTripleExamples >> timBernersLeeGivenNameTriple [
	<gtExample>
	| aTriple |
	aTriple := self emptyTriple.
	aTriple subject: self timBernersLeeSubject.
	aTriple predicate: self givenNamePredicate.
	aTriple object: self timLiteralInEnglishObject.
	self assert: aTriple subject isNotNil.
	^ aTriple.
]

{ #category : #'examples - Tim Berners-Lee' }
RDFTripleExamples >> timBernersLeeResource [
	<gtExample>
	| aResource |
	aResource := DBR resource: 'Tim_Berners-Lee'.
	self assert: (aResource value value endsWith: 'Tim_Berners-Lee').
	^ aResource
]

{ #category : #'examples - Tim Berners-Lee' }
RDFTripleExamples >> timBernersLeeSubject [
	<gtExample>
	| aSubject |
	aSubject := self subjectWith: self timBernersLeeResource.
	self assert: (aSubject term value endsWith: 'Tim_Berners-Lee').
	^ aSubject.
]

{ #category : #'examples - Tim Berners-Lee' }
RDFTripleExamples >> timLiteralInEnglish [
	<gtExample>
	| aLiteral |
	aLiteral := self emptyLiteral.
	aLiteral string: self timName.
	aLiteral language: self englishLanguage.
	self assert: aLiteral value equals: self timName.
	self assert: aLiteral dataType equals: XSD string.
	self assert: aLiteral language tags equals: #( 'en' ).
	self assert: aLiteral printString equals: self timName, '@en'.
	^ aLiteral.
]

{ #category : #'examples - Tim Berners-Lee' }
RDFTripleExamples >> timLiteralInEnglishObject [
	<gtExample>
	| aResource |
	aResource := RDF object: self timLiteralInEnglish.
	self assert: (aResource term value endsWith: 'Tim').
	^ aResource
]

{ #category : #'examples - Tim Berners-Lee' }
RDFTripleExamples >> timName [
	<gtExample>
	^ 'Tim'
]
