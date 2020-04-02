Class {
	#name : #POLYFactory,
	#superclass : #RDFTermFactory,
	#category : #'ResourceDescriptionFramework-Core-Factories'
}

{ #category : #accessing }
POLYFactory >> isRetweet [
	^ self namedNodeSuffix: 'isRetweet'
]

{ #category : #factory }
POLYFactory >> prefix [
	^ 'http://www.polypoly.eu/schema/'
]

{ #category : #factory }
POLYFactory >> shortName [
	^ 'poly'
]

{ #category : #accessing }
POLYFactory >> sphere [
	^ self namedNodeSuffix: 'sphere'
]
