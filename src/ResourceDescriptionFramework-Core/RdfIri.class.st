"
RdfIri is used to represent URI resources where the resource is not part of a defined vocabulary, i.e. there isn't a known namespace.
"
Class {
	#name : #RdfIri,
	#superclass : #RdfResource,
	#category : #'ResourceDescriptionFramework-Core-Model'
}

{ #category : #initialization }
RdfIri >> initialize [ 

	super initialize.
	name := ''.
]

{ #category : #accessing }
RdfIri >> iri [ 

	^ name
]

{ #category : #generated }
RdfIri >> iri: aString [ 

	name := aString
]

{ #category : #printing }
RdfIri >> printSparqlOn: aStream [
	"Print the SPARQL syntax encoding of the receiver on the supplied stream.
	See: https://www.w3.org/TR/2013/REC-sparql11-query-20130321"

	aStream
		nextPut: $<;
		<< name;
		nextPut: $>
]

{ #category : #accessing }
RdfIri >> qualifiedName [
	"Answer the receiver's qualified name, i.e. <namespace>:<name>."

	self error: 'RdfIris don''t have a qualified name'
]
