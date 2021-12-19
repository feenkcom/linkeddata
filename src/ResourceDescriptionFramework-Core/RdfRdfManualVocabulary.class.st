Class {
	#name : #RdfRdfManualVocabulary,
	#superclass : #RdfManualVocabulary,
	#category : 'ResourceDescriptionFramework-Core-Importers'
}

{ #category : #adding }
RdfRdfManualVocabulary >> addToRdfResources [
	| resource |

	namespace := RdfNamespace new 
		name: 'rdf';
		iri: 'http://www.w3.org/1999/02/22-rdf-syntax-ns#'.
	#(type first rest value subject predicate object) do: [ :each |
		resource := RdfProperty new
			name: each;
			namespace: namespace.
		resources at: each put: resource ].
	RdfResources uniqueInstance
		add: namespace;
		addAll: resources.
]

{ #category : #initialization }
RdfRdfManualVocabulary >> initialize [

	super initialize.
	resources := Dictionary new.
]
