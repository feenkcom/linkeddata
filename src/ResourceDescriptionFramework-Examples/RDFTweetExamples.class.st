Class {
	#name : #RDFTweetExamples,
	#superclass : #Object,
	#category : #'ResourceDescriptionFramework-Examples'
}

{ #category : #'examples - tweets' }
RDFTweetExamples >> accountJohnDoeName [
	<gtExample>
	^ RDF tripleBuilder
		subjectIRI: 'https://twitter.com/JohnDoe';
		predicate: SCHEMA name;
		objectLiteral: 'Twitter User john_doe';
		build
]

{ #category : #'examples - tweets' }
RDFTweetExamples >> accountJohnDoeType [
	<gtExample>
	^ RDF tripleBuilder
		subjectIRI: 'https://twitter.com/JohnDoe';
		predicateTerm: RDF type;
		objectTerm: SCHEMA person;
		build
]

{ #category : #'examples - store' }
RDFTweetExamples >> simpleStore [
	<gtExample>
	^ RDFStore simple
		
]

{ #category : #'examples - store' }
RDFTweetExamples >> simpleStoreWithTweets [
	<gtExample>
	| aStore |
	aStore := self simpleStore.
	aStore addTriple: self accountJohnDoeName.
	aStore addTriple: self accountJohnDoeType.
	aStore addTriple: self tweetOneAuthor.
	aStore addTriple: self tweetOneDatePublished.
	aStore addTriple: self tweetOneText.
	aStore addTriple: self tweetOneType.
	^ aStore
]

{ #category : #'examples - tweets' }
RDFTweetExamples >> socialMediaPostingTypeName [
	<gtExample>
	<noTest>
	^ RDF 
		subject: 'http://schema.org/SocialMediaPosting'
		predicate: 'http://www.w3.org/1999/02/22.rdf-syntax-ns#name'
		object: 'human-readable value'
]

{ #category : #'examples - tweets' }
RDFTweetExamples >> tweetOneAuthor [
	<gtExample>
	^ RDF tripleBuilder
		subjectIRI: 'https://twitter.com/JohnDoe/status/tweet-one';
		predicateTerm: SCHEMA author;
		objectIRI: 'https://twitter.com/JohnDoe';
		build
]

{ #category : #'examples - tweets' }
RDFTweetExamples >> tweetOneDatePublished [
	<gtExample>
	^ RDF tripleBuilder
		subjectIRI: 'https://twitter.com/JohnDoe/status/tweet-one';
		predicateTerm: SCHEMA datePublished;
		objectLiteral: '2020-02-25' type: XSD date;
		build.
]

{ #category : #'examples - tweets' }
RDFTweetExamples >> tweetOneText [
	<gtExample>
	^ RDF tripleBuilder
		subjectIRI: 'https://twitter.com/JohnDoe/status/tweet-one';
		predicateTerm: SCHEMA text;
		object: 'My tweet number one';
		build
]

{ #category : #'examples - tweets' }
RDFTweetExamples >> tweetOneType [
	<gtExample>
	^ RDF tripleBuilder
		subjectIRI: 'https://twitter.com/JohnDoe/status/tweet-one';
		predicateTerm: RDF type;
		objectTerm: SCHEMA socialMediaPosting;
		build
]
