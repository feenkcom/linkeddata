Class {
	#name : 'RdfManualVocabulary',
	#superclass : 'Object',
	#instVars : [
		'resources',
		'namespace'
	],
	#category : 'ResourceDescriptionFramework-Core-Importers'
}

{ #category : 'adding' }
RdfManualVocabulary class >> add [ 
	<script>

	self new addToRdfResources
]

{ #category : 'adding' }
RdfManualVocabulary >> addToRdfResources [

	self subclassResponsibility 
]
