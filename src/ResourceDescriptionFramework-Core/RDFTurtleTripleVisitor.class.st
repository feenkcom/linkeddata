"
RDFTurtleTripleVisitor extracts all the triples from a RDFTurtleTurtleDocNode.
"
Class {
	#name : #RDFTurtleTripleVisitor,
	#superclass : #RDFTurtleDocumentNodeVisitor,
	#instVars : [
		'prefixes',
		'triples',
		'subject'
	],
	#category : #'ResourceDescriptionFramework-Core-Parsers'
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
]

{ #category : #accessing }
RDFTurtleTripleVisitor >> prefixes [
	^ prefixes
]

{ #category : #accessing }
RDFTurtleTripleVisitor >> triples [
	^ triples
]

{ #category : #generated }
RDFTurtleTripleVisitor >> visitPredicateObjectList: aPredicateObjectList [
	| objectList |

	1 to: aPredicateObjectList verbs size do: [ :index |
		objectList := aPredicateObjectList objectLists at: index.
		objectList objects do: [ :listObject |
			triples add: (RDFTripleBuilder new 
				subject: subject;
				predicateTerm: ((aPredicateObjectList verbs at: index) asRDFTermFor: self);
				objectTerm: (listObject asRDFTermFor: self);
				build) ] ].
	^ self visitDocument: aPredicateObjectList
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

	subject := (RDFSubject term: (aSubject asRDFTermFor: self)).
	^ self visitDocument: aSubject
]
