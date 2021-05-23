Class {
	#name : #RDFTurtleParserExamples,
	#superclass : #Object,
	#category : #'ResourceDescriptionFramework-Core-Examples'
}

{ #category : #private }
RDFTurtleParserExamples >> documentNamed: basenameString [

	^ ((IceRepository registeredRepositoryIncludingPackage: self class package) location / 'test-data' / basenameString) contents
]

{ #category : #parsing }
RDFTurtleParserExamples >> parseBlankNodeDocument [
	<gtExample>
	| document triples |

	document := self documentNamed: 'blanknodes.turtle'.
	triples := RDFTurtleTripleVisitor parse: document.

	self assert: triples size equals: 29.

	"The triples should be stored in the same order as the document"
	self assert: (triples at: 3) object term label equals: 0.
	self assert: (triples at: 12) object term value equals: 207.5557s4.
	self assert: (triples at: 23) object term value equals: '2021-05-04T13:27:19+00:00' asDateAndTime.

	^ triples
]

{ #category : #parsing }
RDFTurtleParserExamples >> parseSingleTriple [
	<gtExample>
	| document triples triple |

	document :=
'<http://a/b> <http://schema.org/datePublished>
                "2017-01-11T02:27:34+02:00"^^<http://www.w3.org/2001/XMLSchema#dateTime> .'.
	triples := RDFTurtleTripleVisitor parse: document.

	self assert: triples size equals: 1.
	triple := triples first.
	self assert: triple subject term value 
		equals: 'http://a/b'.
	self assert: triple predicate term value equals: 'http://schema.org/datePublished'.
	self assert: triple object term value
		equals: (DateAndTime readFrom: '2017-01-11T02:27:34+02:00' readStream).
	^ triple
]

{ #category : #parsing }
RDFTurtleParserExamples >> parseTwoTriples [
	<gtExample>
	| document triples triple |

	document :=
'<http://a/1> <http://schema.org/datePublished>
                "2017-01-11T02:27:34+02:00"^^<http://www.w3.org/2001/XMLSchema#dateTime> .
<http://a/2> <http://www.w3.org/2001/XMLSchema#integer>
                """42"""^^<http://www.w3.org/2001/XMLSchema#integer> .'.
	triples := RDFTurtleTripleVisitor parse: document.

	self assert: triples size equals: 2.
	"The first triple is tested in #parseSingleTriple"
	triple := triples second.
	self assert: triple subject term value 
		equals: 'http://a/2'.
	self assert: triple predicate term name equals: 'integer'.
	self assert: triple object term value equals: 42.
	^ triples
]
