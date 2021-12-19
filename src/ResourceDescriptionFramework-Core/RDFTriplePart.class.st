Class {
	#name : #RDFTriplePart,
	#superclass : #RDFProtoObject,
	#instVars : [
		'term'
	],
	#category : 'ResourceDescriptionFramework-Core-Model'
}

{ #category : #'instance creation' }
RDFTriplePart class >> iri: aString [ 

	^ self term: (RDFNamedNode new value: aString)
]

{ #category : #'instance creation' }
RDFTriplePart class >> term: aRDFTerm [

	^ self new term: aRDFTerm
]

{ #category : #comparing }
RDFTriplePart >> = aTriplePart [
	^ self class = aTriplePart class and: [ 
		self term = aTriplePart term ]
]

{ #category : #accessing }
RDFTriplePart >> fullName [
	^ self term fullName
]

{ #category : #'gt-extension' }
RDFTriplePart >> gtTermFor: aView [
	<gtView>
	self term ifNil: [ ^ aView empty ].
	^ aView forward
		title: self term termType name;
		object: [ self term ];
		view: #gtValueFor:
]

{ #category : #comparing }
RDFTriplePart >> hash [
	^ self class hash bitXor: self term hash
]

{ #category : #testing }
RDFTriplePart >> isObject [

	^ false
]

{ #category : #testing }
RDFTriplePart >> isPredicate [

	^ false
]

{ #category : #testing }
RDFTriplePart >> isSubject [

	^ false
]

{ #category : #accessing }
RDFTriplePart >> name [
	<return: #String>
	^ self subclassResponsibility
]

{ #category : #printing }
RDFTriplePart >> printOn: aStream [
	self term ifNil: [ ^ super printOn: aStream ].
	self term printShortNameOn: aStream.
]

{ #category : #printing }
RDFTriplePart >> printSparqlOn: aStream [

	term printSparqlOn: aStream
]

{ #category : #accessing }
RDFTriplePart >> shortName [
	^ self term shortName
]

{ #category : #accessing }
RDFTriplePart >> term [
	<return: #RDFTerm>
	^ term
]

{ #category : #accessing }
RDFTriplePart >> term: aRDFTerm [
	self 
		assert: [ aRDFTerm isNotNil ]
		description: [ 'Triple part term must be non-nil' ].
	term := aRDFTerm
]
