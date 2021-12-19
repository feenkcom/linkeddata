Class {
	#name : #DBO,
	#superclass : #RDFConvenience,
	#category : 'ResourceDescriptionFramework-Core-Factories'
}

{ #category : #factory }
DBO class >> factory [
	^ DBOFactory default
]

{ #category : #accessing }
DBO class >> iriNames [

	^ #()
]
