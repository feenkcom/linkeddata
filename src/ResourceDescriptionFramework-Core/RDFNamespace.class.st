Class {
	#name : #RDFNamespace,
	#superclass : #RDFBasicFactory,
	#category : #'ResourceDescriptionFramework-Core-Factories'
}

{ #category : #factory }
RDFNamespace >> foaf [
	^ self link: 'http://xmlns.com/foaf/0.1/'
]

{ #category : #accessing }
RDFNamespace >> link: aString [
	<return: #RDFNamedNode>
	^ RDF namedNode: aString
]

{ #category : #factory }
RDFNamespace >> rdf [
	^ self link: 'http://www.w3.org/1999/02/22-rdf-syntax-ns#'
]

{ #category : #factory }
RDFNamespace >> rdfs [
	^ self link: 'http://www.w3.org/2000/01/rdf-schema#'
]

{ #category : #factory }
RDFNamespace >> xsd [
	^ self link: 'http://www.w3.org/2001/XMLSchema#'
]
