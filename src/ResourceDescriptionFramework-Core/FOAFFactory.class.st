Class {
	#name : 'FOAFFactory',
	#superclass : 'RDFTermFactory',
	#category : 'ResourceDescriptionFramework-Core-Factories'
}

{ #category : 'testing' }
FOAFFactory class >> isDeprecated [ 
	"RDF is deprecated, RdfVocabularies should be used instead"
	
	^ true
]

{ #category : 'factory' }
FOAFFactory >> givenName [
	^ self namedNodeSuffix: 'givenName'
]

{ #category : 'factory' }
FOAFFactory >> prefix [
	^ 'http://xmlns.com/foaf/0.1/'
]

{ #category : 'factory' }
FOAFFactory >> shortName [
	^ 'foaf'
]
