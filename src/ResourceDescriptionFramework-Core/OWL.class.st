Class {
	#name : 'OWL',
	#superclass : 'RDFConvenience',
	#category : 'ResourceDescriptionFramework-Core-Factories'
}

{ #category : 'factory' }
OWL class >> factory [
	^ OWLFactory default
]

{ #category : 'accessing' }
OWL class >> iriNames [

	^ #()
]
