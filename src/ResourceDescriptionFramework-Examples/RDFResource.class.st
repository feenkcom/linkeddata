Class {
	#name : #RDFResource,
	#superclass : #Object,
	#instVars : [
		'metaDescription',
		'triples'
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
RDFResource >> triples [
	^ triples
]

{ #category : #accessing }
RDFResource >> triples: anObject [
	triples := anObject
]
