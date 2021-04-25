Class {
	#name : #RDFTurtleNumericLiteralNode,
	#superclass : #RDFTurtleDocumentNode,
	#instVars : [
		'literal'
	],
	#category : #'ResourceDescriptionFramework-Core-Parsers'
}

{ #category : #generated }
RDFTurtleNumericLiteralNode >> acceptVisitor: aDocumentVisitor [
	^ aDocumentVisitor visitNumericLiteral: self
]

{ #category : #converting }
RDFTurtleNumericLiteralNode >> asRDFTermFor: aVisitor [
	| dataType string |

	string := literal value.
	(string allSatisfy: #isDigit) ifTrue: 
		[ dataType := XSD integer ]
	ifFalse: [ ('\d+(\.\d*)?' asRegex matches: string) ifTrue:
		[ dataType := XSD decimal ]
	ifFalse: [ ('\d+\.\d+[eE]\d+' asRegex matches: string) ifTrue:
		[ dataType := XSD double ]
	ifFalse:
		[ self error: 'Unknown numeric type' ] ] ].
	^ RDFLiteral new value: string dataType: dataType
]

{ #category : #generated }
RDFTurtleNumericLiteralNode >> literal [
	^ literal
]

{ #category : #generated }
RDFTurtleNumericLiteralNode >> literal: aSmaCCToken [
	literal := aSmaCCToken
]

{ #category : #generated }
RDFTurtleNumericLiteralNode >> tokenVariables [
	^ #(#literal)
]
