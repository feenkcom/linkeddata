Class {
	#name : #XSDFactory,
	#superclass : #RDFTermFactory,
	#category : #'ResourceDescriptionFramework-Core-Factories'
}

{ #category : #factory }
XSDFactory >> boolean [
	<return: #RDFNamedNode>

	^ self 
		namedNodeSuffix: 'boolean'
		parser: [ :aString | XSD parseBoolean: aString ]
]

{ #category : #factory }
XSDFactory >> date [
	<return: #RDFNamedNode>
	^ self namedNodeSuffix: 'date'
]

{ #category : #factory }
XSDFactory >> dateTime [
	<return: #RDFNamedNode>
	^ self 
		namedNodeSuffix: 'dateTime'
		parser: [ :aString | XSD parseDateTime: aString ]
]

{ #category : #factory }
XSDFactory >> decimal [
	<return: #RDFNamedNode>

	^ self 
		namedNodeSuffix: 'decimal'
		parser: [ :aString | XSD parseDecimal: aString ]
]

{ #category : #factory }
XSDFactory >> double [
	<return: #RDFNamedNode>

	^ self 
		namedNodeSuffix: 'double'
		parser: [ :aString | XSD parseDouble: aString ]
]

{ #category : #factory }
XSDFactory >> integer [
	<return: #RDFNamedNode>

	^ self 
		namedNodeSuffix: 'integer'
		parser: [ :aString | XSD parseInteger: aString ]
]

{ #category : #factory }
XSDFactory >> prefix [
	<return: #String>
	^ 'http://www.w3.org/2001/XMLSchema#'
]

{ #category : #factory }
XSDFactory >> shortName [
	^ 'xsd'
]

{ #category : #factory }
XSDFactory >> string [
	<return: #RDFNamedNode>
	^ self namedNodeSuffix: 'string'
]
