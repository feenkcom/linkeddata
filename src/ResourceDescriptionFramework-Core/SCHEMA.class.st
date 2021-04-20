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
SCHEMA class >> dateCreated [
	^ self factory dateCreated
]

{ #category : #factory }
SCHEMA class >> datePublished [
	^ self factory datePublished
]

{ #category : #factory }
SCHEMA class >> factory [
	^ SCHEMAFactory default
]

{ #category : #factory }
SCHEMA class >> identifier [
	^ self factory identifier
]

{ #category : #factory }
SCHEMA class >> mentions [
	^ self factory mentions
]

{ #category : #factory }
SCHEMA class >> name1 [
	^ self factory name
]

{ #category : #factory }
SCHEMA class >> person [
	^ self factory person
]

{ #category : #factory }
SCHEMA class >> socialMediaPosting [
	^ self factory socialMediaPosting
]

{ #category : #factory }
SCHEMA class >> text [
	^ self factory text
]
