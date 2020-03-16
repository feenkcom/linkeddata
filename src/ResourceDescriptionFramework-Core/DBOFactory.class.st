Class {
	#name : #DBOFactory,
	#superclass : #RDFTermFactory,
	#category : #'ResourceDescriptionFramework-Core-Factories'
}

{ #category : #factory }
DBOFactory >> prefix [
	^ 'http://dbpedia.org/ontology/'
]

{ #category : #factory }
DBOFactory >> shortName [
	^ 'dbo'
]
