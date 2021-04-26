Class {
	#name : #SCHEMAFactory,
	#superclass : #RDFTermFactory,
	#category : #'ResourceDescriptionFramework-Core-Factories'
}

{ #category : #'accessing - property' }
SCHEMAFactory >> author [
	^ self namedNodeSuffix: 'author'
]

{ #category : #'accessing - property' }
SCHEMAFactory >> contentUrl [
	^ self namedNodeSuffix: 'contentUrl'
]

{ #category : #'accessing - property' }
SCHEMAFactory >> dateCreated [
	^ self namedNodeSuffix: 'dateCreated'
]

{ #category : #'accessing - property' }
SCHEMAFactory >> datePublished [
	^ self namedNodeSuffix: 'datePublished'
]

{ #category : #'accessing - property' }
SCHEMAFactory >> identifier [
	^ self namedNodeSuffix: 'identifier'
]

{ #category : #'accessing - property' }
SCHEMAFactory >> image [
	^ self namedNodeSuffix: 'image'
]

{ #category : #'accessing - type' }
SCHEMAFactory >> imageObject [
	^ self namedNodeSuffix: 'ImageObject'
]

{ #category : #'accessing - property' }
SCHEMAFactory >> mentions [
	^ self namedNodeSuffix: 'mentions'
]

{ #category : #accessing }
SCHEMAFactory >> name [
	^ self namedNodeSuffix: 'Name'
]

{ #category : #'accessing - type' }
SCHEMAFactory >> person [
	^ self namedNodeSuffix: 'Person'
]

{ #category : #factory }
SCHEMAFactory >> prefix [
	<return: #String>
	^ 'http://schema.org/'
]

{ #category : #factory }
SCHEMAFactory >> shortName [
	^ 'schema'
]

{ #category : #'accessing - type' }
SCHEMAFactory >> socialMediaPosting [
	^ self namedNodeSuffix: 'SocialMediaPosting'
]

{ #category : #accessing }
SCHEMAFactory >> text [
	^ self namedNodeSuffix: 'text'
]
