"
RDFTurtleTripleVisitor extracts all the triples from a RDFTurtleTurtleDocNode.

"
Class {
	#name : #RDFTurtleTripleVisitor,
	#superclass : #RDFTurtleDocumentNodeVisitor,
	#instVars : [
		'prefixes',
		'triples',
		'subject',
		'predicate',
		'object',
		'resources',
		'tripleBuilder',
		'blankNodeIndex'
	],
	#category : 'ResourceDescriptionFramework-Core-Parsers'
}

{ #category : #parsing }
RDFTurtleTripleVisitor class >> parse: aRDFTurtleDocumentString [
	"Parse the supplied TURTLE document (String) and answer the collection of triples"
	| visitor |

	visitor := self new.
	(RDFTurtleParser parse: aRDFTurtleDocumentString) acceptVisitor: visitor.
	^ visitor triples
]

{ #category : #initialization }
RDFTurtleTripleVisitor >> initialize [ 

	super initialize.
	triples := OrderedCollection new.
	prefixes := Dictionary new.
	resources := RdfResources uniqueInstance.
	tripleBuilder := RDFTripleBuilder new.
	blankNodeIndex := -1.
]

{ #category : #accessing }
RDFTurtleTripleVisitor >> nextBlankNodeIndex [
	"Answer the next index to be used for RdfBlankNodes"

	^ blankNodeIndex := blankNodeIndex + 1
]

{ #category : #accessing }
RDFTurtleTripleVisitor >> prefixes [
	^ prefixes
]

{ #category : #accessing }
RDFTurtleTripleVisitor >> resources [
	^ resources
]

{ #category : #accessing }
RDFTurtleTripleVisitor >> triples [
	^ triples
]

{ #category : #generated }
RDFTurtleTripleVisitor >> visitBlankNodePropertyList: aBlankNodePropertyList [
	| oldSubject |

	oldSubject := subject.
	subject := object.
	self visitDocument: aBlankNodePropertyList.
	subject := oldSubject.
]

{ #category : #generated }
RDFTurtleTripleVisitor >> visitObject: aRdfTurtleObjectNode [

	object := aRdfTurtleObjectNode asRDFTermFor: self.
	triples add: (tripleBuilder
		objectTerm: object;
		build).
	self visitDocument: aRdfTurtleObjectNode.
]

{ #category : #generated }
RDFTurtleTripleVisitor >> visitPrefixID: aPrefixID [
	| iri url |

	iri := aPrefixID iri value.
	url := iri copyFrom: 2 to: iri size - 1.
	prefixes at: aPrefixID name value put: url.
	^ self visitDocument: aPrefixID
]

{ #category : #generated }
RDFTurtleTripleVisitor >> visitSubject: aSubject [

	tripleBuilder subjectTerm: (subject := aSubject asRDFTermFor: self).
	^ self visitDocument: aSubject
]

{ #category : #generated }
RDFTurtleTripleVisitor >> visitVerb: aVerb [

	tripleBuilder predicateTerm: (predicate := aVerb asRDFTermFor: self).
	^ self visitDocument: aVerb
]
