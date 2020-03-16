Class {
	#name : #XSD,
	#superclass : #RDFConvenience,
	#category : #'ResourceDescriptionFramework-Core-Factories'
}

{ #category : #accessing }
XSD class >> factory [
	^ XSDFactory default
]

{ #category : #factory }
XSD class >> namedNode: aString [
	^ self factory namedNode: aString
]

{ #category : #factory }
XSD class >> string [
	^ self factory string
]
