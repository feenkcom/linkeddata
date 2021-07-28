Class {
	#name : 'RDFTurtleIriNode',
	#superclass : 'RDFTurtleDocumentNode',
	#instVars : [
		'iri'
	],
	#category : 'ResourceDescriptionFramework-Core-Parsers'
}

{ #category : 'generated' }
RDFTurtleIriNode >> acceptVisitor: aDocumentVisitor [
	^ aDocumentVisitor visitIri: self
]

{ #category : 'converting' }
RDFTurtleIriNode >> asRDFTermFor: aVisitor [
	| iriString |

	iriString := self urlWithPrefixes: aVisitor prefixes.
	^ aVisitor resources 
		atIRI: iriString
		ifAbsent: [ RDFNamedNode new value: iriString ]
]

{ #category : 'generated' }
RDFTurtleIriNode >> iri [
	^ iri
]

{ #category : 'generated' }
RDFTurtleIriNode >> iri: aSmaCCToken [
	iri := aSmaCCToken
]

{ #category : 'generated' }
RDFTurtleIriNode >> tokenVariables [
	^ #(#iri)
]

{ #category : 'accessing' }
RDFTurtleIriNode >> url [ 
	"Answer the receiver's url.
	This can only be used if the iri is in the form '<url>'"

	(iri value first = $<) ifFalse:
		[ self error: 'doesnt handle named nodes, e.g. rdfs:label' ].
	^ iri value copyFrom: 2 to: iri value size - 1
]

{ #category : 'accessing' }
RDFTurtleIriNode >> urlWithPrefixes: aDictionary [
	"Answer the receiver's url"
	| iriValue colonIndex namespace name |

	iriValue := iri value.
	(iriValue first = $<) ifTrue:
		[ ^ iriValue copyFrom: 2 to: iri value size - 1 ].

	colonIndex := iriValue indexOf: $:.
	namespace := iriValue copyFrom: 1 to: colonIndex.
	name := iriValue copyFrom: colonIndex+1 to: iri size.
	^ (aDictionary at: namespace), name
]
