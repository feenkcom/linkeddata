Class {
	#name : #RDFSubject,
	#superclass : #RDFTriplePart,
	#category : 'ResourceDescriptionFramework-Core-Model'
}

{ #category : #testing }
RDFSubject >> isSubject [

	^ true
]

{ #category : #accessing }
RDFSubject >> name [
	^ 'Subject'
]
