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
RdfResource >> printOn: aStream [

	label ifNotNil: [ ^ aStream << label ].
	name ifNotNil: [ ^ aStream << name ].
	super printOn: aStream
]

{ #category : #printing }
RdfResource >> printSparqlOn: aStream [
	"Print the SPARQL syntax encoding of the receiver on the supplied stream.
	See: https://www.w3.org/TR/2013/REC-sparql11-query-20130321"

	aStream 
		nextPut: $<;
		<< self iri;
		nextPut: $>.
]

{ #category : #accessing }
RdfResource >> qualifiedName [
	"Answer the receiver's qualified name, i.e. <namespace>:<name>."

	^ self subclassResponsibility
]
