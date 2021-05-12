Class {
	#name : #RdfClass,
	#superclass : #RdfResource,
	#instVars : [
		'namespace'
	],
	#category : #'ResourceDescriptionFramework-Core-Model'
}

{ #category : #accessing }
RdfClass >> iri [ 

	^ namespace iri, name
]

{ #category : #testing }
RdfClass >> isRdfClass [ 

	^ true
]

{ #category : #accessing }
RdfClass >> namespace [
	^ namespace
]

{ #category : #accessing }
RdfClass >> namespace: anObject [
	namespace := anObject
]

{ #category : #printing }
RdfClass >> printOn: aStream [

	name ifNotNil: 
		[ namespace ifNotNil: [ aStream << namespace name; << ':' ].
		aStream << name ]
	ifNil:
		[ super printOn: aStream ]
]

{ #category : #accessing }
RdfClass >> qualifiedName [
	"Answer the receiver's qualified name, i.e. <namespace>:<name>."

	^ namespace name, ':', name
]
