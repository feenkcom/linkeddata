"
For a discussion of 'literal' vs 'typed-literal', see https://jena.apache.org/documentation/notes/typed-literals.html

"
Class {
	#name : #RDFTypedLiteral,
	#superclass : #RDFLiteral,
	#category : #'ResourceDescriptionFramework-Core-Model'
}

{ #category : #accessing }
RDFTypedLiteral class >> typeName [ 
	"Answer the type the receiver represents."

	^ #'typed-literal'
]
