"
RDFTurtleTripleVisitor extracts all the triples from a RDFTurtleTurtleDocNode.
"
Class {
	#name : #RDFTurtleTripleVisitor,
	#superclass : #RDFTurtleDocumentNodeVisitor,
	#traits : 'TRDFTurtleDocumentNodeVisitor',
	#classTraits : 'TRDFTurtleDocumentNodeVisitor classTrait',
	#instVars : [
		'triples',
		'subject'
	],
	#category : #'ResourceDescriptionFramework-Core-Parsers'
}

{ #category : #initialization }
RDFTurtleTripleVisitor >> initialize [ 

	super initialize.
	triples := OrderedCollection new.
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
				predicateTerm: (aPredicateObjectList verbs at: index) asRDFTerm;
				objectTerm: listObject asRDFTerm;
				build) ] ].
	^ self visitDocument: aPredicateObjectList
]

{ #category : #generated }
RDFTurtleTripleVisitor >> visitSubject: aSubject [

	subject := (RDFSubject term: aSubject asRDFTerm).
	^ self visitDocument: aSubject
]
