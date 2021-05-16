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
RdfNamespace >> gtPropertiesFor: aView [
	<gtView>

	name ifNil: [ ^ aView empty ].
	^ aView columnedList 
		title: 'Properties';
		priority: 20;
		items: [ self properties sorted: [ :a :b | a name < b name ] ];
		column: 'Name' text: [ :item | item name ];
		column: 'Comment' text: [ :item | item comment ]
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

{ #category : #printing }
RdfNamespace >> printSparqlOn: aStream [
	"Print the SPARQL syntax encoding of the receiver on the supplied stream.
	See: https://www.w3.org/TR/2013/REC-sparql11-query-20130321"

	aStream
		<< name;
		nextPut: $:
]

{ #category : #accessing }
RdfNamespace >> properties [ 
	"Answer the receiver's properties"

	^ RdfResources uniqueInstance resources
		select: [ :each | each isRdfProperty and: [ each namespace name = name ] ]
]

{ #category : #accessing }
RdfNamespace >> qualifiedName [
	"Answer the receiver's qualified name.
	For a namespace, this is the name"

	^ name
]
