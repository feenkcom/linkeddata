Class {
	#name : #RDFFactory,
	#superclass : #RDFTermFactory,
	#category : #'ResourceDescriptionFramework-Core-Factories'
}

{ #category : #factory }
RDFFactory >> literal: aValue [
	<return: #RDFLiteral>
	^ self literal: aValue type: XSD string
]

{ #category : #factory }
RDFFactory >> literal: aValue type: aNamedNode [
	<return: #RDFLiteral>
	^ RDFLiteral new
		value: aValue;
		dataType: aNamedNode
]

{ #category : #factory }
RDFFactory >> namedNode: aString inNamespace: aNamespace [
	<return: #RDFShortNamedNode>
	self 
		assert: [ aString isString and: [ aString isNotEmpty ] ] 
		description: [ 'Named node value must be non-empty string' ].
	self 
		assert: [ aNamespace isNotNil ] 
		description: [ 'Namespace must be non-nil' ].
	^ RDFShortNamedNode new
		value: aString;
		namespace: aNamespace
]

{ #category : #factory }
RDFFactory >> namespaceValue: aNamespaceString shortName: aShortNameString [
	<return: #RDFNamespaceNamedNode>
	self 
		assert: [ aNamespaceString isString and: [ aNamespaceString isNotEmpty ] ] 
		description: [ 'Namespace value must be non-empty string' ].
	self 
		assert: [ aShortNameString isString and: [ aShortNameString isNotEmpty ] ] 
		description: [ 'Namespace short name must be non-empty string' ].
	^ RDFNamespaceNamedNode new
		value: aNamespaceString;
		shortName: aShortNameString
]

{ #category : #factory }
RDFFactory >> object: aTerm [
	^ RDFObject new term: aTerm
]

{ #category : #factory }
RDFFactory >> predicate: aTerm [
	^ RDFPredicate new term: aTerm
]

{ #category : #factory }
RDFFactory >> prefix [
	^ 'http://www.w3.org/1999/02/22-rdf-syntax-ns#'
]

{ #category : #factory }
RDFFactory >> shortName [
	^ 'rdf'
]

{ #category : #accessing }
RDFFactory >> string [
	<return: #RDFNamedNode>
	^ self namedNode: 'http://www.w3.org/2001/XMLSchema#string'
]

{ #category : #factory }
RDFFactory >> subject: aTerm [
	^ RDFSubject new term: aTerm
]

{ #category : #factory }
RDFFactory >> triple [
	^ RDFTriple new
]
