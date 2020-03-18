Class {
	#name : #POLY,
	#superclass : #RDFConvenience,
	#category : #'ResourceDescriptionFramework-Core-Factories'
}

{ #category : #factory }
POLY class >> factory [
	^ POLYFactory default
]

{ #category : #factory }
POLY class >> sphere [
	^ self factory sphere
]
