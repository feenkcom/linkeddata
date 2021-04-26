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
RDFBlankNode >> label [
	"Answer the receiver's (optional) label"
	<return: #String>

	^ value
]

{ #category : #accessing }
RDFBlankNode >> label: aString [

	value := aString
]

{ #category : #accessing }
RDFBlankNode >> termType [
	^ RDFTermType blankNode
]
