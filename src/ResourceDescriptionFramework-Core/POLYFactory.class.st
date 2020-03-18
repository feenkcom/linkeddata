Class {
	#name : #POLYFactory,
	#superclass : #RDFTermFactory,
	#category : #'ResourceDescriptionFramework-Core-Factories'
}

{ #category : #factory }
POLYFactory >> prefix [
	^ 'http://www.polypoly.tech/2020/02/02/'
]

{ #category : #factory }
POLYFactory >> shortName [
	^ 'poly'
]

{ #category : #accessing }
POLYFactory >> sphere [
	^ self namedNodeSuffix: 'sphere'
]
