Class {
	#name : #RDFTriple,
	#superclass : #RDFProtoObject,
	#instVars : [
		'subject',
		'predicate',
		'object'
	],
	#category : #'ResourceDescriptionFramework-Core-Model'
}

{ #category : #'gt-extension' }
RDFTriple >> gtPartsFor: aView [
	<gtView>
	^ aView list
		title: 'Parts';
		priority: 2;
		items: [ self parts ]
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

{ #category : #accessing }
RDFTriple >> sentence [
	<return: #String>
	^ String streamContents: [ :aStream | 
		self subject ifNotNil: [ :aSubject | aStream print: aSubject; space ].
		self predicate ifNotNil: [ :aPredicate | aStream print: aPredicate; nextPutAll: ' is ' ].
		self object ifNotNil: [ :anObject | aStream print: anObject; nextPut: $. ].  ]
]

{ #category : #accessing }
RDFTriple >> subject [
	^ subject
]

{ #category : #accessing }
RDFTriple >> subject: anObject [
	subject := anObject
]
