Class {
	#name : #RdfNamespace,
	#superclass : #RdfResource,
	#instVars : [
		'iri'
	],
	#category : #'ResourceDescriptionFramework-Core-Model'
}

{ #category : #'as yet unclassified' }
RdfNamespace class >> name: nameString iri: iriString [

	^ self new name: nameString iri: iriString
]

{ #category : #accessing }
RdfNamespace >> iri [
	^ iri
]

{ #category : #accessing }
RdfNamespace >> iri: anObject [
	iri := anObject
]

{ #category : #testing }
RdfNamespace >> isRdfNamespace [

	^ true
]

{ #category : #initialization }
RdfNamespace >> name: nameString iri: iriString [

	name := nameString.
	iri := iriString.
]

{ #category : #printing }
RdfNamespace >> printOn: aStream [

	(name isNil and: [ iri isNil ]) ifTrue:
		[ ^ super printOn: aStream ].

	aStream
		<< name;
		<< ': ';
		<< iri
]

{ #category : #accessing }
RdfNamespace >> qualifiedName [
	"Answer the receiver's qualified name.
	For a namespace, this is the name"

	^ name
]
