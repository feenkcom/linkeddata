Class {
	#name : #RdfProperty,
	#superclass : #RdfResource,
	#instVars : [
		'namespace'
	],
	#category : #'ResourceDescriptionFramework-Core-Model'
}

{ #category : #accessing }
RdfProperty >> iri [ 

	^ namespace iri, name
]

{ #category : #testing }
RdfProperty >> isRdfProperty [

	^ true
]

{ #category : #accessing }
RdfProperty >> namespace [
	^ namespace
]

{ #category : #accessing }
RdfProperty >> namespace: anObject [
	namespace := anObject
]

{ #category : #printing }
RdfProperty >> printOn: aStream [

	name ifNotNil: 
		[ namespace ifNotNil: [ aStream << namespace name; << ':' ].
		aStream << name ]
	ifNil:
		[ super printOn: aStream ]
]

{ #category : #accessing }
RdfProperty >> qualifiedName [
	"Answer the receiver's qualified name, i.e. <namespace>:<name>."

	^ namespace name, ':', name
]
