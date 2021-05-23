Class {
	#name : #RdfResources,
	#superclass : #RDFProtoObject,
	#traits : 'TGtUniqueInstance',
	#classTraits : 'TGtUniqueInstance classTrait',
	#instVars : [
		'resourcesByName',
		'resourcesByIRI',
		'namespaces'
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

	RdfManualVocabulary subclassesDo: [ :subClass | subClass add ].

	RdfFoafVocabularyImporter new
		file: vocabDirectory / 'foaf-rdf.xml';
		name: 'foaf';
		import.
	RdfExifVocabularyImporter new
		file: vocabDirectory / 'exif-rdf.xml';
		name: 'exif';
		import.
	RdfGpxVocabularyImporter new
		file: vocabDirectory / 'gpx-rdf.xml';
		name: 'gpx';
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
	aRdfResource isRdfNamespace ifTrue: [ namespaces add: aRdfResource qualifiedName ].
]

{ #category : #adding }
RdfResources >> addAll: aCollection [

	aCollection do: [ :each | self add: each ]
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

{ #category : #ui }
RdfResources >> gtNamespacesFor: aView [
	<gtView>

	(namespaces isNil or: [ namespaces isEmpty ]) ifTrue: [ ^ aView empty ].
	^ aView list 
		title: 'Namespaces';
		priority: 10;
		items: [ namespaces sorted collect: [ :each | self atName: each ] ]
]

{ #category : #initialization }
RdfResources >> initialize [ 

	super initialize.
	resourcesByName := Dictionary new.
	resourcesByIRI := Dictionary new.
	namespaces := Set new.
]

{ #category : #accessing }
RdfResources >> predicateAtName: aString [

	^ RDFPredicate term: (resourcesByName at: aString)

]

{ #category : #accessing }
RdfResources >> predicateAtName: aString ifAbsent: absentBlock [

	^ resourcesByName at: aString 
		ifPresent: [ :term | RDFPredicate term: term ]
		ifAbsent: absentBlock
]

{ #category : #printing }
RdfResources >> printNamespacesOn: aStream [
	"Print the receiver's known namespaces on the supplied stream in sparql format"

	namespaces do: [ :namespace |
		aStream
			<< 'prefix ';
			<< namespace;
			<< ': <';
			<< (resourcesByName at: namespace) iri;
			<< '>';
			cr ]
]

{ #category : #accessing }
RdfResources >> resourceNames [ 
	"Answer the names of all the known resources"

	^ resourcesByName keys
]

{ #category : #accessing }
RdfResources >> resources [
	"Answer the known resources"

	^ resourcesByName values
]