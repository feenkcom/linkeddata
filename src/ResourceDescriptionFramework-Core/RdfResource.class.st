Class {
	#name : #RdfResource,
	#superclass : #RDFProtoObject,
	#instVars : [
		'name',
		'label',
		'comment'
	],
	#category : #'ResourceDescriptionFramework-Core-Model'
}

{ #category : #accessing }
RdfResource >> comment [
	^ comment
]

{ #category : #accessing }
RdfResource >> comment: anObject [
	comment := anObject
]

{ #category : #printing }
RdfResource >> description [ 

	^ String streamContents: [ :stream |
		self printDescriptionOn: stream ]
]

{ #category : #accessing }
RdfResource >> fullName [ 

	^ String streamContents: [ :stream |
		self printFullNameOn: stream ]
]

{ #category : #accessing }
RdfResource >> fullNameWithDataType [
	"RDFTerm compatibility"

	^ self printString
]

{ #category : #ui }
RdfResource >> gtDescriptionFor: aView [
	<gtView>

	^ aView textEditor 
		title: 'Description';
		priority: 10;
		text: [ self description asRopedText glamorousCodeFont ]
]

{ #category : #ui }
RdfResource >> gtValueFor: aView [

	^ self gtDescriptionFor: aView
]

{ #category : #accessing }
RdfResource >> iri [ 

	^ self subclassResponsibility 
]

{ #category : #testing }
RdfResource >> isRdfClass [ 

	^ false
]

{ #category : #testing }
RdfResource >> isRdfNamespace [

	^ false
]

{ #category : #testing }
RdfResource >> isRdfProperty [

	^ false
]

{ #category : #accessing }
RdfResource >> label [
	^ label
]

{ #category : #accessing }
RdfResource >> label: anObject [
	label := anObject
]

{ #category : #accessing }
RdfResource >> name [
	^ name
]

{ #category : #accessing }
RdfResource >> name: anObject [
	name := anObject
]

{ #category : #printing }
RdfResource >> printDescriptionOn: stream [

	self printOn: stream.
	stream cr; cr.
	stream 
		<< 'IRI:    ';
		<< self iri;
		cr.
	stream 
		<< 'Label:  ';
		<< (label ifNil: [ '' ]);
		cr.
	stream
		<< 'Comment:'; cr;
		<< (comment ifNil: [ '' ]);
		cr.
]

{ #category : #printing }
RdfResource >> printFullNameOn: stream [

	stream 
		nextPut: $<;
		<< self iri;
		nextPut: $>
]

{ #category : #printing }
RdfResource >> printOn: aStream [

	label ifNotNil: [ ^ aStream << label ].
	name ifNotNil: [ ^ aStream << name ].
	super printOn: aStream
]

{ #category : #printing }
RdfResource >> printSparqlOn: aStream [
	"Print the SPARQL syntax encoding of the receiver on the supplied stream.
	See: https://www.w3.org/TR/2013/REC-sparql11-query-20130321"

	self subclassResponsibility 
]

{ #category : #accessing }
RdfResource >> qualifiedName [
	"Answer the receiver's qualified name, i.e. <namespace>:<name>."

	^ self subclassResponsibility
]
