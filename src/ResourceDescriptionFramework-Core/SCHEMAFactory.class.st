Class {
	#name : #SCHEMAFactory,
	#superclass : #RDFTermFactory,
	#category : #'ResourceDescriptionFramework-Core-Factories'
}

{ #category : #accessing }
SCHEMAFactory >> author [
	^ self namedNodeSuffix: 'author'
]

{ #category : #accessing }
SCHEMAFactory >> datePublished [
	^ self namedNodeSuffix: 'datePublished'
]

{ #category : #accessing }
SCHEMAFactory >> person [
	^ self namedNodeSuffix: 'Person'
]

{ #category : #factory }
SCHEMAFactory >> prefix [
	<return: #String>
	^ 'http://schema.org'
]

{ #category : #factory }
SCHEMAFactory >> shortName [
	^ 'schema'
]

{ #category : #accessing }
SCHEMAFactory >> socialMediaPosting [
	^ self namedNodeSuffix: 'SocialMediaPosting'
]

{ #category : #accessing }
SCHEMAFactory >> text [
	^ self namedNodeSuffix: 'text'
]
