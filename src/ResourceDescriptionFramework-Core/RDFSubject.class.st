Class {
	#name : #RDFSubject,
	#superclass : #RDFTriplePart,
	#category : #'ResourceDescriptionFramework-Core-Model'
}

{ #category : #comparing }
RDFSubject >> = aSubject [
	^ self class = aSubject class and: [ 
		self term = aSubject term ]
]

{ #category : #accessing }
RDFSubject >> name [
	^ 'Subject'
]
