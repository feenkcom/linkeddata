Class {
	#name : #RdfODRL22VocabularyImporter,
	#superclass : #RdfVocabularyImporter,
	#category : #'ResourceDescriptionFramework-Core-Importers'
}

{ #category : #private }
RdfODRL22VocabularyImporter >> addClass: aXMLElement [
	"Add a RdfClass based on the supplied element"
	|className  rdfClass |

	className := aXMLElement attributeAt: #'rdf:about'.
	className := className copyFrom: self namespace iri size + 1 to: className size.
	rdfClass := RdfClass new.
	rdfClass 
		name: className;
		namespace: self namespace;
		label: ((aXMLElement attributeAt: #'rdfs:label') ifEmpty: [ nil ]);
		comment: ((aXMLElement attributeAt: #'rdfs:comment') ifEmpty: [ nil ]).
	resources at: rdfClass qualifiedName put: rdfClass.
]

{ #category : #private }
RdfODRL22VocabularyImporter >> addProperty: aXMLElement [
	"Add a RdfClass based on the supplied element"
	| rdfClass fullName simpleName |
	
	rdfClass := RdfProperty new.
	fullName := aXMLElement attributeAt: #'rdf:about'.
	simpleName := fullName copyFrom: self namespace iri size + 1 to: fullName size.
	rdfClass 
		name: simpleName;
		namespace: self namespace;
		label: (aXMLElement contentStringAt: #label);
		comment: (aXMLElement contentStringAt: #comment).
	resources at: rdfClass qualifiedName put: rdfClass.
]

{ #category : #private }
RdfODRL22VocabularyImporter >> findNamespaces [
	"Its own namespace is empty, we add it manually for now"

	super findNamespaces.

	"Remove broken namespaces"
	namespaces
		removeKey: ''.

	namespace := RdfNamespace name: self name iri: 'http://www.w3.org/ns/odrl/2/'.
	namespaces at: self name put: namespace.
]
