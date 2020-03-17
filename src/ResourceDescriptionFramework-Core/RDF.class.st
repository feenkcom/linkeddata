Class {
	#name : #RDF,
	#superclass : #RDFConvenience,
	#category : #'ResourceDescriptionFramework-Core-Factories'
}

{ #category : #accessing }
RDF class >> factory [
	^ RDFFactory default
]

{ #category : #accessing }
RDF class >> language [
	^ RDFLanguageFactory default
]

{ #category : #factory }
RDF class >> literal: aValue [
	<return: #RDFLiteral>
	^ self factory literal: aValue
]

{ #category : #factory }
RDF class >> literal: aValue type: aNamedNode [
	<return: #RDFLiteral>
	^ self factory literal: aValue type: aNamedNode
]

{ #category : #factory }
RDF class >> namedNode: aString [
	^ self factory namedNode: aString
]

{ #category : #factory }
RDF class >> namedNode: aString inNamespace: aNamespace [
	<return: #RDFShortNamedNode>
	^ self factory namedNode: aString inNamespace: aNamespace
]

{ #category : #factory }
RDF class >> namespaceValue: aNamespaceString shortName: aShortNameString [
	<return: #RDFNamespaceNamedNode>
	^ self factory namespaceValue: aNamespaceString shortName: aShortNameString
]

{ #category : #factory }
RDF class >> object: aTerm [
	<return: #RDFObject>
	^ self factory object: aTerm
]

{ #category : #factory }
RDF class >> predicate: aTerm [
	<return: #RDFPredicate>
	^ self factory predicate: aTerm
]

{ #category : #factory }
RDF class >> subject: aTerm [
	<return: #RDFSubject>
	^ self factory subject: aTerm
]

{ #category : #factory }
RDF class >> triple [
	<return: #RDFTriple>
	^ self factory triple
]

{ #category : #builder }
RDF class >> tripleBuilder [
	^ RDFTripleBuilder new
]
