"
RdfVocabularyImporter assists with importing vocabularies that are specified in XML format.

Unfortunately the format is rather loose, so a subclass is added for each known vocabulary.
"
Class {
	#name : #RdfVocabularyImporter,
	#superclass : #Object,
	#instVars : [
		'xmlDoc',
		'name',
		'namespaces',
		'resources',
		'namespace'
	],
	#category : #'ResourceDescriptionFramework-Core-Importers'
}

{ #category : #'instance creation' }
RdfVocabularyImporter class >> fromFile: aFileReference shortName: aString [

	^ self new 
		xmlDoc: (XMLDOMParser parse: aFileReference asFileReference contents);
		shortName: aString
]

{ #category : #private }
RdfVocabularyImporter >> addClass: aXMLElement [
	"Add a RdfClass based on the supplied element"

	self subclassResponsibility 
]

{ #category : #private }
RdfVocabularyImporter >> addProperty: aXMLElement [
	"Add a RdfClass based on the supplied element"

	self subclassResponsibility
]

{ #category : #accessing }
RdfVocabularyImporter >> file: aFileReference [ 

	xmlDoc := XMLDOMParser parse: aFileReference asFileReference contents.
]

{ #category : #private }
RdfVocabularyImporter >> findNamespaces [
	"Find the namespaces.
	Use known namespaces from RdfResources, but don't add new ones yet"
	| knownResources |

	knownResources := RdfResources uniqueInstance.

	xmlDoc firstNode namespaceNodes do: [ :each |
		namespaces at: each name put: 
			(knownResources atName: each name ifAbsent: 
				[ RdfNamespace name: each name iri: each uri ]) ]
]

{ #category : #private }
RdfVocabularyImporter >> findResources [
	"Iterate over all the elements and extract the resources"

	xmlDoc firstNode nodes elements do: [ :each | 
		each name = #'rdfs:Class' ifTrue: 
			[ self addClass: each ]
		ifFalse: [ each name = #'rdf:Property' ifTrue: 
			[ self addProperty: each ] ] ]
]

{ #category : #importing }
RdfVocabularyImporter >> import [ 

	self findNamespaces.
	self findResources.
	RdfResources uniqueInstance
		addAll: namespaces;
		addAll: resources.
]

{ #category : #private }
RdfVocabularyImporter >> initialize [

	super initialize.
	namespaces := Dictionary new.
	resources := Dictionary new.
]

{ #category : #accessing }
RdfVocabularyImporter >> name [
	^ name
]

{ #category : #accessing }
RdfVocabularyImporter >> name: anObject [
	name := anObject
]

{ #category : #accessing }
RdfVocabularyImporter >> namespace [ 

	^ namespace ifNil: [ namespace := namespaces at: name ]
]

{ #category : #accessing }
RdfVocabularyImporter >> xmlDoc [
	^ xmlDoc
]

{ #category : #accessing }
RdfVocabularyImporter >> xmlDoc: anObject [
	xmlDoc := anObject
]
