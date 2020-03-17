Class {
	#name : #RDFResource,
	#superclass : #Object,
	#instVars : [
		'metaDescription',
		'triplets'
	],
	#category : #'ResourceDescriptionFramework-Examples'
}

{ #category : #accessing }
RDFResource >> metaDescription [
	^ metaDescription
]

{ #category : #accessing }
RDFResource >> metaDescription: anObject [
	metaDescription := anObject
]

{ #category : #accessing }
RDFResource >> triplets [
	^ triplets
]

{ #category : #accessing }
RDFResource >> triplets: anObject [
	triplets := anObject
]
