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
RDFTriple >> gtSentenceFor: aView [
	<gtView>
	self subject ifNil: [ ^ aView empty ].
	self predicate ifNil: [ ^ aView empty ].
	self object ifNil: [ ^ aView empty ].
	^ aView textEditor
		title: 'Sentence';
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
		self predicate ifNotNil: [ :aSubject | aStream print: aSubject; space ].
		self object ifNotNil: [ :aSubject | aStream print: aSubject; nextPut: $. ].  ]
]

{ #category : #accessing }
RDFTriple >> subject [
	^ subject
]

{ #category : #accessing }
RDFTriple >> subject: anObject [
	subject := anObject
]
