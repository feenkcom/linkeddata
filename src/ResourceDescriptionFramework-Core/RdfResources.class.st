Class {
	#name : #RdfResources,
	#superclass : #RDFProtoObject,
	#traits : 'TGtUniqueInstance',
	#classTraits : 'TGtUniqueInstance classTrait',
	#instVars : [
		'resourcesByName',
		'resourcesByIRI'
	],
	#category : #'ResourceDescriptionFramework-Core-Collections'
}

{ #category : #'instance creation' }
RdfResources class >> newLoaded [
	"Answer an instance of the receiver loaded with the known vocabularies"
	| vocabDirectory |

	uniqueInstance := self new.
	vocabDirectory := (IceRepository registry 
		detect: [ :each | each name = #linkeddata ]) location resolve / 'vocabularies'.

	RdfRdfManualVocabulary new addToRdfResources.
	RdfFoafVocabularyImporter new
		file: vocabDirectory / 'foaf-rdf.xml';
		name: 'foaf';
		import.
	RdfExifVocabularyImporter new
		file: vocabDirectory / 'exif-rdf.xml';
		name: 'exif';
		import.
	^ uniqueInstance
]

{ #category : #accessing }
RdfResources class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self newLoaded ]
]

{ #category : #adding }
RdfResources >> add: aRdfResource [

	resourcesByName at: aRdfResource qualifiedName put: aRdfResource.
	resourcesByIRI at: aRdfResource iri put: aRdfResource.
]

{ #category : #adding }
RdfResources >> addAll: aCollection [

	aCollection do: [ :each |
		resourcesByName at: each qualifiedName put: each.
		resourcesByIRI at: each iri put: each. ]
]

{ #category : #accessing }
RdfResources >> atIRI: aString [ 

	^ resourcesByIRI at: aString
]

{ #category : #accessing }
RdfResources >> atName: aString [ 

	^ resourcesByName at: aString
]

{ #category : #accessing }
RdfResources >> atName: aString ifAbsent: absentBlock [

	^ resourcesByName at: aString ifAbsent: absentBlock
]

{ #category : #initialization }
RdfResources >> initialize [ 

	super initialize.
	resourcesByName := Dictionary new.
	resourcesByIRI := Dictionary new.
]
