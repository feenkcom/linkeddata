Class {
	#name : #RDFPredicate,
	#superclass : #RDFTriplePart,
	#category : #'ResourceDescriptionFramework-Core-Model'
}

{ #category : #comparing }
RDFPredicate >> = anObject [
	"Answer a boolean indicating whether the receiver is considered equal to anObject.
	RDFPredicates are considered equal if they have the same IRI.
	Note that the term may be different classes, e.g. RDFNamedNode or RdfProperty."

	^ self class = anObject class and:
		[ term iri asLowercase = anObject term iri asLowercase ]
]

{ #category : #converting }
RDFPredicate >> asPredicate [

	^ self
]

{ #category : #comparing }
RDFPredicate >> hash [

	^ self class hash bitXor: term iri asLowercase hash
]

{ #category : #accessing }
RDFPredicate >> iri [

	^ term iri
]

{ #category : #testing }
RDFPredicate >> isPredicate [ 

	^ true
]

{ #category : #accessing }
RDFPredicate >> name [
	^ 'Predicate'
]
