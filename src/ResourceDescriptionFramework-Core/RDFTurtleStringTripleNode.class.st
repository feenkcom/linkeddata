Class {
	#name : 'RDFTurtleStringTripleNode',
	#superclass : 'RDFTurtleDocumentNode',
	#instVars : [
		'string'
	],
	#category : 'ResourceDescriptionFramework-Core-Parsers'
}

{ #category : 'generated' }
RDFTurtleStringTripleNode >> acceptVisitor: aDocumentVisitor [
	^ aDocumentVisitor visitStringTriple: self
]

{ #category : 'generated' }
RDFTurtleStringTripleNode >> string [
	^ string
]

{ #category : 'generated' }
RDFTurtleStringTripleNode >> string: aSmaCCToken [
	string := aSmaCCToken
]

{ #category : 'generated' }
RDFTurtleStringTripleNode >> tokenVariables [
	^ #(#string)
]

{ #category : 'evaluating' }
RDFTurtleStringTripleNode >> value [ 

	^ string value copyFrom: 4 to: string value size - 3
]
