Class {
	#name : 'RDFTurtleStringSingleNode',
	#superclass : 'RDFTurtleDocumentNode',
	#instVars : [
		'string'
	],
	#category : 'ResourceDescriptionFramework-Core-Parsers'
}

{ #category : 'generated' }
RDFTurtleStringSingleNode >> acceptVisitor: aDocumentVisitor [
	^ aDocumentVisitor visitStringSingle: self
]

{ #category : 'generated' }
RDFTurtleStringSingleNode >> string [
	^ string
]

{ #category : 'generated' }
RDFTurtleStringSingleNode >> string: aSmaCCToken [
	string := aSmaCCToken
]

{ #category : 'generated' }
RDFTurtleStringSingleNode >> tokenVariables [
	^ #(#string)
]

{ #category : 'evaluating' }
RDFTurtleStringSingleNode >> value [ 

	^ string value copyFrom: 2 to: string value size - 1
]
