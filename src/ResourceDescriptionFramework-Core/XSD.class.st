Class {
	#name : #XSD,
	#superclass : #RDFConvenience,
	#category : #'ResourceDescriptionFramework-Core-Factories'
}

{ #category : #factory }
XSD class >> boolean [
	^ self factory boolean
]

{ #category : #factory }
XSD class >> date [
	^ self factory date
]

{ #category : #factory }
XSD class >> dateTime [
	^ self factory dateTime
]

{ #category : #factory }
XSD class >> decimal [
	^ self factory decimal
]

{ #category : #accessing }
XSD class >> factory [
	^ XSDFactory default
]

{ #category : #factory }
XSD class >> integer [
	^ self factory integer
]

{ #category : #factory }
XSD class >> namedNode: aString [
	^ self factory namedNode: aString
]

{ #category : #factory }
XSD class >> string [
	^ self factory string
]
