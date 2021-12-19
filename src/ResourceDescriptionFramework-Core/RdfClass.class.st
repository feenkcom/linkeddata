"
RdfClass represents a URI reference to a class.

The namespace of the class is held in `namespace`, the local name is held in `name`.

"
Class {
	#name : #RdfClass,
	#superclass : #RdfResource,
	#instVars : [
		'namespace'
	],
	#category : 'ResourceDescriptionFramework-Core-Model'
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

{ #category : #printing }
RdfClass >> printSparqlOn: aStream [
	"Print the SPARQL syntax encoding of the receiver on the supplied stream.
	See: https://www.w3.org/TR/2013/REC-sparql11-query-20130321"

	aStream
		<< namespace name;
		nextPut: $:;
		<< name
]

{ #category : #accessing }
RdfClass >> qualifiedName [
	"Answer the receiver's qualified name, i.e. <namespace>:<name>."

	^ namespace name, ':', name
]
