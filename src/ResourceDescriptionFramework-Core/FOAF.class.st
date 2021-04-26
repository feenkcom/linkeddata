Class {
	#name : #FOAF,
	#superclass : #RDFConvenience,
	#category : #'ResourceDescriptionFramework-Core-Factories'
}

{ #category : #factory }
FOAF class >> factory [
	^ FOAFFactory default
]

{ #category : #factory }
FOAF class >> givenName [
	^ self factory givenName
]

{ #category : #accessing }
FOAF class >> iriNames [

	^ #(givenName)
]
