Class {
	#name : #POLY,
	#superclass : #RDFConvenience,
	#category : #'ResourceDescriptionFramework-Core-Factories'
}

{ #category : #factory }
POLY class >> baseDomain [
	^ self factory baseDomain
]

{ #category : #factory }
POLY class >> factory [
	^ POLYFactory default
]

{ #category : #factory }
POLY class >> isRetweet [
	^ self factory isRetweet
]

{ #category : #factory }
POLY class >> sphere [
	^ self factory sphere
]
