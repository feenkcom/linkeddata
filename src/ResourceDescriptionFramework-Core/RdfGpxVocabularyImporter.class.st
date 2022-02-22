Class {
	#name : #RdfGpxVocabularyImporter,
	#superclass : #RdfVocabularyImporter,
	#category : #'ResourceDescriptionFramework-Core-Importers'
}

{ #category : #private }
RdfGpxVocabularyImporter >> addClass: aXMLElement [
	"Add a RdfClass based on the supplied element"

	self error: 'The definition at the time didn''t define any classes'
]

{ #category : #private }
RdfGpxVocabularyImporter >> addProperty: aXMLElement [
	"Add a RdfClass based on the supplied element"
	| propertyName hashIndex rdfClass |

	propertyName := aXMLElement attributeAt: #'rdf:about'.
	hashIndex := propertyName indexOf: $#.
	self assert: hashIndex > 0.
	propertyName := propertyName copyFrom: hashIndex + 1 to: propertyName size.
	rdfClass := RdfProperty new.
	rdfClass 
		name: propertyName;
		namespace: self namespace;
		label: (aXMLElement contentStringAt: #label);
		comment: (aXMLElement contentStringAt: #comment).
	resources at: rdfClass qualifiedName put: rdfClass.
]

{ #category : #private }
RdfGpxVocabularyImporter >> findNamespaces [
	"GPX doesn't seem to specify its own namespace"

	super findNamespaces.

	"Remove broken namespaces"
	namespaces
		removeKey: '';
		removeKey: #s.

	"Add GPX"
	namespace := RdfNamespace name: #gpx iri: 'http://www.w3.org/ns/pim/gpx#'.
	namespaces at: #gpx put: namespace.
]
