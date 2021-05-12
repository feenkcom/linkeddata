Class {
	#name : #RDFPredicate,
	#superclass : #RDFTriplePart,
	#category : #'ResourceDescriptionFramework-Core-Model'
}

{ #category : #testing }
RDFPredicate >> isPredicate [ 

	^ true
]

{ #category : #accessing }
RDFPredicate >> name [
	^ 'Predicate'
]
