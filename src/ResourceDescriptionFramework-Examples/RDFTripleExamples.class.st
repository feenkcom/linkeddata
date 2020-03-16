Class {
	#name : #RDFTripleExamples,
	#superclass : #Object,
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
	aLanguage := self emptyLanguage.
	aLanguage tag: 'en'.
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

{ #category : #'examples - basic' }
RDFTripleExamples >> predicateWith: aTerm [
	<gtExample>
	| aPredicate |
	aPredicate := RDF predicate: aTerm.
	self assert: aPredicate term equals: aTerm.
	^ aPredicate
]

{ #category : #'examples - Tim Berners-Lee' }
RDFTripleExamples >> timBernersLeeGivenName [
	<gtExample>
	| aTriple |
	aTriple := self emptyTriple.
	aTriple subject: self timBernersLeeSubject.
	aTriple predicate: self givenNamePredicate.
	aTriple object: self timLiteralInEnglish.
	self assert: aTriple subject isNotNil.
	^ aTriple.
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
RDFTripleExamples >> timName [
	<gtExample>
	^ 'Tim'
]
