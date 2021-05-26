Class {
	#name : #RDFBlankNode,
	#superclass : #RDFTerm,
	#category : #'ResourceDescriptionFramework-Core-Model'
}

{ #category : #'instance creation' }
RDFBlankNode class >> fromJsonDictionary: aDictionary [
	"Answer an instance of the appropriate subclass.
	aDictionary follows the structure defined at https://www.w3.org/TR/sparql11-results-json/"

	^ self new label: (aDictionary at: #value)
]

{ #category : #accessing }
RDFBlankNode class >> typeName [ 
	"Answer the type the receiver represents."

	^ #bnode
]

{ #category : #accessing }
RDFBlankNode >> iri [ 
	"The printString is currently the same as the iri"

	^ String streamContents: [ :stream |
		self printOn: stream ]
]

{ #category : #accessing }
RDFBlankNode >> label [ 
	"Answer the receiver's label.
	Labels can be any simple string (no spaces), but are often sequential numbers"
	<return: #String or: #Integer>

	^ value
]

{ #category : #accessing }
RDFBlankNode >> label: aStringOrInteger [

	value := aStringOrInteger 
]

{ #category : #printing }
RDFBlankNode >> printOn: aStream [

	value ifNil: [ ^ super printOn: aStream ].

	aStream
		<< '_:';
		<< value asString
]

{ #category : #printing }
RDFBlankNode >> printSparqlOn: aStream [
	"Print the SPARQL syntax encoding of the receiver on the supplied stream.
	See: https://www.w3.org/TR/2013/REC-sparql11-query-20130321"

	aStream
		<< '_:b';
		<< value asString
]

{ #category : #accessing }
RDFBlankNode >> termType [
	^ RDFTermType blankNode
]
