Class {
	#name : #RDFPredicate,
	#superclass : #RDFTriplePart,
	#category : #'ResourceDescriptionFramework-Core-Model'
}

{ #category : #converting }
RDFPredicate >> asPredicate [

	^ self
]

{ #category : #testing }
RDFPredicate >> isPredicate [ 

	^ true
]

{ #category : #accessing }
RDFPredicate >> name [
	^ 'Predicate'
]
