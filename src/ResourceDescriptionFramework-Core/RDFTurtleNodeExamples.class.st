Class {
	#name : #RDFTurtleNodeExamples,
	#superclass : #Object,
	#category : #'ResourceDescriptionFramework-Core-Examples'
}

{ #category : #'examples - NumericLiteral' }
RDFTurtleNodeExamples >> booleanLiteralFalse [
	<gtExample>
	| node term |

	node := RDFTurtleBooleanLiteralNode new literal: 'false'.
	term := node asRDFTermFor: RDFTurtleTripleVisitor new.
	self assert: term value.
	self assert: term dataType equals: XSD boolean.
	^ term
	
]

{ #category : #'examples - NumericLiteral' }
RDFTurtleNodeExamples >> booleanLiteralTrue [
	<gtExample>
	| node term |

	node := RDFTurtleBooleanLiteralNode new literal: 'true'.
	term := node asRDFTerm.
	self assert: term value.
	self assert: term dataType equals: XSD boolean.
	^ term
	
]

{ #category : #'examples - NumericLiteral' }
RDFTurtleNodeExamples >> numericLiteralDecimal [
	<gtExample>
	| node term |

	node := RDFTurtleNumericLiteralNode new literal: '4.2'.
	term := node asRDFTerm.
	self assert: term value equals: 4.2s2.
	self assert: term dataType equals: XSD decimal.
	^ term
	
]

{ #category : #'examples - NumericLiteral' }
RDFTurtleNodeExamples >> numericLiteralDouble [
	<gtExample>
	| node term |

	node := RDFTurtleNumericLiteralNode new literal: '4.2E1'.
	term := node asRDFTerm.
	self assert: term value equals: 4.2e1.
	self assert: term dataType equals: XSD double.
	^ term
	
]

{ #category : #'examples - NumericLiteral' }
RDFTurtleNodeExamples >> numericLiteralInteger [
	<gtExample>
	| node term |

	node := RDFTurtleNumericLiteralNode new literal: '42'.
	term := node asRDFTerm.
	self assert: term value equals: 42.
	self assert: term dataType equals: XSD integer.
	^ term
	
]
