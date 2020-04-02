Class {
	#name : #RDFTriple,
	#superclass : #RDFProtoObject,
	#instVars : [
		'subject',
		'predicate',
		'object',
		'store'
	],
	#category : #'ResourceDescriptionFramework-Core-Model'
}

{ #category : #'instance creation' }
RDFTriple class >> fromNTriple: aString [
	"Answer an instance based on the values in the supplied N-Triple"
	| fields subject predicate |

	"Assume single tab based separation for now"
	fields := Character tab split: aString.
	"N-Triples have four fields: subject predicate object ."
	self assert: fields size equals: 4.
	self assert: fields last equals: '.'.
	"IRIs are enclosed in angle brackets"
	subject := fields first copyFrom: 2 to: fields first size - 1.
	predicate := fields second copyFrom: 2 to: fields second size - 1.

	^ RDF tripleBuilder
		subjectIRI: subject;
		predicateIRI: predicate;
		objectNTerm: fields third;
		build.

]

{ #category : #'gt-extension' }
RDFTriple >> gtPartsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Parts';
		priority: 2;
		items: [ self parts ];
		column: 'Part' item: [ :aPart | aPart name ] width: 80;
		column: 'Term' item: [ :aPart | aPart ]
]

{ #category : #'gt-extension' }
RDFTriple >> gtSentenceFor: aView [
	<gtView>
	self subject ifNil: [ ^ aView empty ].
	self predicate ifNil: [ ^ aView empty ].
	self object ifNil: [ ^ aView empty ].
	^ aView textEditor
		title: 'Sentence';
		priority: 1;
		glamorousRegularFontAndSize;
		text: [ self sentence ]
]

{ #category : #accessing }
RDFTriple >> object [
	^ object
]

{ #category : #accessing }
RDFTriple >> object: anObject [
	object := anObject
]

{ #category : #accessing }
RDFTriple >> parts [
	^ Array new: 3 streamContents: [ :aStream | 
		self subject ifNotNil: [ :aSubject | aStream nextPut: aSubject ].
		self predicate ifNotNil: [ :aPredicate | aStream nextPut: aPredicate ].
		self object ifNotNil: [ :anObject | aStream nextPut: anObject ] ]
]

{ #category : #accessing }
RDFTriple >> predicate [
	^ predicate
]

{ #category : #accessing }
RDFTriple >> predicate: anObject [
	predicate := anObject
]

{ #category : #printing }
RDFTriple >> printOn: aStream [
	self subject ifNil: [ ^ super printOn: aStream ].
	self printSentenceOn: aStream
]

{ #category : #printing }
RDFTriple >> printSentenceOn: aStream [
	self subject ifNotNil: [ :aSubject | 
		aStream print: aSubject; space ].
	self predicate ifNotNil: [ :aPredicate | 
		aStream nextPutAll: 'has a '; print: aPredicate ].
	self object ifNotNil: [ :anObject | 
		aStream nextPutAll: ' whose value is '; print: anObject; nextPut: $. ].
]

{ #category : #accessing }
RDFTriple >> sentence [
	<return: #String>
	^ String streamContents: [ :aStream | 
		self printSentenceOn: aStream ]
]

{ #category : #accessing }
RDFTriple >> store [
	^ store
]

{ #category : #accessing }
RDFTriple >> store: anObject [
	store := anObject
]

{ #category : #accessing }
RDFTriple >> subject [
	^ subject
]

{ #category : #accessing }
RDFTriple >> subject: anObject [
	subject := anObject
]
