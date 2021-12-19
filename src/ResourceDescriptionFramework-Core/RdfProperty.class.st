"
RdfProperty represents a URI reference to a property.  RdfPropertys are used as the predicates in RDF triples.

The namespace of the class is held in `namespace`, the local name is held in `name`.

"
Class {
	#name : #RdfProperty,
	#superclass : #RdfResource,
	#instVars : [
		'namespace'
	],
	#category : 'ResourceDescriptionFramework-Core-Model'
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

{ #category : #printing }
RdfProperty >> printSparqlOn: aStream [
	"Print the SPARQL syntax encoding of the receiver on the supplied stream.
	See: https://www.w3.org/TR/2013/REC-sparql11-query-20130321"

	aStream
		<< namespace name;
		nextPut: $:;
		<< name
]

{ #category : #accessing }
RdfProperty >> qualifiedName [
	"Answer the receiver's qualified name, i.e. <namespace>:<name>."

	^ namespace name, ':', name
]

{ #category : #accessing }
RdfProperty >> termType [
	"Compatibility with RDFNamedNode"

	^ RDFTermType namedNode
]
