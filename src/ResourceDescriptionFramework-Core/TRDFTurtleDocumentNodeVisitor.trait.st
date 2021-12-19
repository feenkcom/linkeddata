Trait {
	#name : #TRDFTurtleDocumentNodeVisitor,
	#traits : 'TSmaCCParseNodeVisitor',
	#classTraits : 'TSmaCCParseNodeVisitor classTrait',
	#category : 'ResourceDescriptionFramework-Core-Parsers'
}

{ #category : #generated }
TRDFTurtleDocumentNodeVisitor >> visitAPredicate: anAPredicate [
	^ self visitDocument: anAPredicate
]

{ #category : #generated }
TRDFTurtleDocumentNodeVisitor >> visitBase: aBase [
	^ self visitDocument: aBase
]

{ #category : #generated }
TRDFTurtleDocumentNodeVisitor >> visitBlankNodePropertyList: aBlankNodePropertyList [
	^ self visitDocument: aBlankNodePropertyList
]

{ #category : #generated }
TRDFTurtleDocumentNodeVisitor >> visitBooleanLiteral: aBooleanLiteral [
	^ self visitDocument: aBooleanLiteral
]

{ #category : #generated }
TRDFTurtleDocumentNodeVisitor >> visitCollection: aCollection [
	^ self visitDocument: aCollection
]

{ #category : #generated }
TRDFTurtleDocumentNodeVisitor >> visitDirective: aDirective [
	^ self visitDocument: aDirective
]

{ #category : #generated }
TRDFTurtleDocumentNodeVisitor >> visitDocument: aDocument [
	^ self visitSmaCCParseNode: aDocument
]

{ #category : #generated }
TRDFTurtleDocumentNodeVisitor >> visitIri: anIri [
	^ self visitDocument: anIri
]

{ #category : #generated }
TRDFTurtleDocumentNodeVisitor >> visitLiteral: aLiteral [
	^ self visitDocument: aLiteral
]

{ #category : #generated }
TRDFTurtleDocumentNodeVisitor >> visitNumericLiteral: aNumericLiteral [
	^ self visitDocument: aNumericLiteral
]

{ #category : #generated }
TRDFTurtleDocumentNodeVisitor >> visitObject: anObject [
	^ self visitDocument: anObject
]

{ #category : #generated }
TRDFTurtleDocumentNodeVisitor >> visitObjectList: anObjectList [
	^ self visitDocument: anObjectList
]

{ #category : #generated }
TRDFTurtleDocumentNodeVisitor >> visitPredicate: aPredicate [
	^ self visitDocument: aPredicate
]

{ #category : #generated }
TRDFTurtleDocumentNodeVisitor >> visitPredicateObjectList: aPredicateObjectList [
	^ self visitDocument: aPredicateObjectList
]

{ #category : #generated }
TRDFTurtleDocumentNodeVisitor >> visitPrefixID: aPrefixID [
	^ self visitDocument: aPrefixID
]

{ #category : #generated }
TRDFTurtleDocumentNodeVisitor >> visitRdfLiteral: aRdfLiteral [
	^ self visitDocument: aRdfLiteral
]

{ #category : #generated }
TRDFTurtleDocumentNodeVisitor >> visitSparqlBase: aSparqlBase [
	^ self visitDocument: aSparqlBase
]

{ #category : #generated }
TRDFTurtleDocumentNodeVisitor >> visitSparqlPrefix: aSparqlPrefix [
	^ self visitDocument: aSparqlPrefix
]

{ #category : #generated }
TRDFTurtleDocumentNodeVisitor >> visitStatement: aStatement [
	^ self visitDocument: aStatement
]

{ #category : #generated }
TRDFTurtleDocumentNodeVisitor >> visitStringDouble: aStringDouble [
	^ self visitDocument: aStringDouble
]

{ #category : #generated }
TRDFTurtleDocumentNodeVisitor >> visitStringSingle: aStringSingle [
	^ self visitDocument: aStringSingle
]

{ #category : #generated }
TRDFTurtleDocumentNodeVisitor >> visitStringTriple: aStringTriple [
	^ self visitDocument: aStringTriple
]

{ #category : #generated }
TRDFTurtleDocumentNodeVisitor >> visitSubject: aSubject [
	^ self visitDocument: aSubject
]

{ #category : #generated }
TRDFTurtleDocumentNodeVisitor >> visitTriples: aTriples [
	^ self visitDocument: aTriples
]

{ #category : #generated }
TRDFTurtleDocumentNodeVisitor >> visitTurtleDoc: aTurtleDoc [
	^ self visitDocument: aTurtleDoc
]

{ #category : #generated }
TRDFTurtleDocumentNodeVisitor >> visitVerb: aVerb [
	^ self visitDocument: aVerb
]
