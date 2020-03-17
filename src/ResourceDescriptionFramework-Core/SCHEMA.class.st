Class {
	#name : #SCHEMA,
	#superclass : #RDFConvenience,
	#category : #'ResourceDescriptionFramework-Core-Factories'
}

{ #category : #factory }
SCHEMA class >> author [
	^ self factory author
]

{ #category : #factory }
SCHEMA class >> factory [
	^ SCHEMAFactory default
]
