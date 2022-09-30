Class {
	#name : #DBR,
	#superclass : #RDFConvenience,
	#category : 'ResourceDescriptionFramework-Core-Factories'
}

{ #category : #factory }
DBR class >> factory [
	^ DBRFactory default
]

{ #category : #accessing }
DBR class >> iriNames [

	^ #()
]

{ #category : #factory }
DBR class >> resource: aString [
	<return: #RDFNamedNode>
	^ self factory resource: aString
]
