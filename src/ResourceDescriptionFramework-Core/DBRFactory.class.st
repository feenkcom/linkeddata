Class {
	#name : #DBRFactory,
	#superclass : #RDFTermFactory,
	#category : #'ResourceDescriptionFramework-Core-Factories'
}

{ #category : #factory }
DBRFactory >> prefix [
	^ 'http://dbpedia.org/resource/'
]

{ #category : #factory }
DBRFactory >> resource: aString [
	<return: #RDFNamedNode>
	^ self namedNodeSuffix: aString
]

{ #category : #factory }
DBRFactory >> shortName [
	^ 'dbr'
]
