Class {
	#name : #RDFTweetExamples,
	#superclass : #Object,
	#category : #'ResourceDescriptionFramework-Examples'
}

{ #category : #'examples - tweets' }
RDFTweetExamples >> accountJohnDoeName [
	<gtExample>
	^ RDFTriple new 
		subject: 'https://twitter.com/JohnDoe';
		predicate: 'http://shema.org/Name';
		object: 'Twitter User john_doe'
]

{ #category : #'examples - tweets' }
RDFTweetExamples >> accountJohnDoeType [
	<gtExample>
	^ RDFTriple new 
		subject: 'https://twitter.com/JohnDoe';
		predicate: 'http://www.w3.org/1999/02/22.rdf-syntax-ns#type';
		object: 'http://schema.org/Person'
]

{ #category : #'examples - tweets' }
RDFTweetExamples >> socialMediaPostingTypeName [
	<gtExample>
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
		predicateNamespaceIRI: 'http://schema.org/' as: 'schema' suffix: 'datePublished';
		objectLiteral: '2020-02-25' type: XSD date;
		build.
]

{ #category : #'examples - tweets' }
RDFTweetExamples >> tweetOneText [
	<gtExample>
	^ RDFTriple new 
		subject: 'https://twitter.com/JohnDoe/status/tweet-one';
		predicate: 'http://schema.org/text';
		object: 'My tweet number one'
]

{ #category : #'examples - tweets' }
RDFTweetExamples >> tweetOneType [
	<gtExample>
	^ RDFTriple new 
		subject: 'https://twitter.com/JohnDoe/status/tweet-one';
		predicate: 'http://www.w3.org/1999/02/22.rdf-syntax-ns#type';
		object: 'http://schema.org/SocialMediaPosting'
]
