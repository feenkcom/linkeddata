Class {
	#name : #SCHEMAFactory,
	#superclass : #RDFTermFactory,
	#category : #'ResourceDescriptionFramework-Core-Factories'
}

{ #category : #accessing }
SCHEMAFactory >> author [
	^ self namedNodeSuffix: 'author'
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
