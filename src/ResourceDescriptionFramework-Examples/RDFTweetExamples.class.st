Class {
	#name : #RDFTweetExamples,
	#superclass : #Object,
	#category : #'ResourceDescriptionFramework-Examples'
}

{ #category : #'examples - account' }
RDFTweetExamples >> accountJohnDoeIRI [
	^ 'https://twitter.com/JohnDoe'
]

{ #category : #'examples - account' }
RDFTweetExamples >> accountJohnDoeName [
	<gtExample>
	^ RDF tripleBuilder
		subjectIRI: self accountJohnDoeIRI;
		predicateTerm: SCHEMA name1;
		objectLiteral: 'Twitter User john_doe';
		build
]

{ #category : #'examples - account' }
RDFTweetExamples >> accountJohnDoeType [
	<gtExample>
	^ RDF tripleBuilder
		subjectIRI: self accountJohnDoeIRI;
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
RDFTweetExamples >> simpleStoreWithOneTweet [
	<gtExample>
	| aStore |
	aStore := self simpleStore.
	aStore addTriple: self accountJohnDoeName.
	aStore addTriple: self accountJohnDoeType.
	aStore addTriple: self tweetOneAuthor.
	aStore addTriple: self tweetOneDatePublished.
	aStore addTriple: self tweetOneText.
	aStore addTriple: self tweetOneType.
	aStore addTriple: self tweetOneTweetSphere.
	^ aStore
]

{ #category : #'examples - store' }
RDFTweetExamples >> simpleStoreWithTwoTweets [
	<gtExample>
	| aStore |
	aStore := self simpleStore.
	aStore addTriple: self accountJohnDoeName.
	aStore addTriple: self accountJohnDoeType.
	aStore addTriple: self tweetOneAuthor.
	aStore addTriple: self tweetOneDatePublished.
	aStore addTriple: self tweetOneText.
	aStore addTriple: self tweetOneType.
	aStore addTriple: self tweetOneTweetSphere.
	aStore addTriple: self tweetTwoAuthor.
	aStore addTriple: self tweetTwoDatePublished.
	aStore addTriple: self tweetTwoText.
	aStore addTriple: self tweetTwoType.
	aStore addTriple: self tweetTwoTweetSphere.
	^ aStore
]

{ #category : #'examples - todo' }
RDFTweetExamples >> socialMediaPostingTypeName [
	<gtExample>
	<noTest>
	^ RDF 
		subject: 'http://schema.org/SocialMediaPosting'
		predicate: 'http://www.w3.org/1999/02/22.rdf-syntax-ns#name'
		object: 'human-readable value'
]

{ #category : #'examples - tweet one' }
RDFTweetExamples >> tweetOneAuthor [
	<gtExample>
	^ RDF tripleBuilder
		subjectIRI: self tweetOneIRI;
		predicateTerm: SCHEMA author;
		objectIRI: self accountJohnDoeIRI;
		build
]

{ #category : #'examples - tweet one' }
RDFTweetExamples >> tweetOneDatePublished [
	<gtExample>
	^ RDF tripleBuilder
		subjectIRI: self tweetOneIRI;
		predicateTerm: SCHEMA datePublished;
		objectLiteral: '2020-02-25T10:25:00' asDateAndTime type: XSD date;
		build.
]

{ #category : #'examples - tweet one' }
RDFTweetExamples >> tweetOneIRI [
	^ 'https://twitter.com/JohnDoe/status/tweet-one'
]

{ #category : #'examples - tweet one' }
RDFTweetExamples >> tweetOneText [
	<gtExample>
	^ RDF tripleBuilder
		subjectIRI: self tweetOneIRI;
		predicateTerm: SCHEMA text;
		objectLiteral: 'My tweet number one';
		build
]

{ #category : #'examples - sphere' }
RDFTweetExamples >> tweetOneTweetSphere [
	<gtExample>
	^ RDF tripleBuilder
		subjectIRI: self tweetOneIRI;
		predicateTerm: POLY sphere;
		objectLiteral: 'tweet';
		build
]

{ #category : #'examples - tweet one' }
RDFTweetExamples >> tweetOneType [
	<gtExample>
	^ RDF tripleBuilder
		subjectIRI: self tweetOneIRI;
		predicateTerm: RDF type;
		objectTerm: SCHEMA socialMediaPosting;
		build
]

{ #category : #'examples - tweet two' }
RDFTweetExamples >> tweetTwoAuthor [
	<gtExample>
	^ RDF tripleBuilder
		subjectIRI: self tweetTwoIRI;
		predicateTerm: SCHEMA author;
		objectIRI: self accountJohnDoeIRI;
		build
]

{ #category : #'examples - tweet two' }
RDFTweetExamples >> tweetTwoDatePublished [
	<gtExample>
	^ RDF tripleBuilder
		subjectIRI: self tweetTwoIRI;
		predicateTerm: SCHEMA datePublished;
		objectLiteral: '2020-02-26T16:16:16' asDateAndTime type: XSD date;
		build.
]

{ #category : #'examples - tweet two' }
RDFTweetExamples >> tweetTwoIRI [
	^ 'https://twitter.com/JohnDoe/status/tweet-two'
]

{ #category : #'examples - tweet two' }
RDFTweetExamples >> tweetTwoText [
	<gtExample>
	^ RDF tripleBuilder
		subjectIRI: self tweetTwoIRI;
		predicateTerm: SCHEMA text;
		objectLiteral: 'My tweet number two';
		build
]

{ #category : #'examples - sphere' }
RDFTweetExamples >> tweetTwoTweetSphere [
	<gtExample>
	^ RDF tripleBuilder
		subjectIRI: self tweetOneIRI;
		predicateTerm: POLY sphere;
		objectLiteral: 'tweet';
		build
]

{ #category : #'examples - tweet two' }
RDFTweetExamples >> tweetTwoType [
	<gtExample>
	^ RDF tripleBuilder
		subjectIRI: self tweetTwoIRI;
		predicateTerm: RDF type;
		objectTerm: SCHEMA socialMediaPosting;
		build
]
