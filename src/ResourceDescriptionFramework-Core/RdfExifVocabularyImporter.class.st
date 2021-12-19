Class {
	#name : #RdfExifVocabularyImporter,
	#superclass : #RdfVocabularyImporter,
	#category : 'ResourceDescriptionFramework-Core-Importers'
}

{ #category : #private }
RdfExifVocabularyImporter >> addClass: aXMLElement [
	"Add a RdfClass based on the supplied element"
	| rdfClass |

	rdfClass := RdfClass new.
	rdfClass 
		name: (aXMLElement attributeAt: #'rdf:ID');
		namespace: self namespace;
		label: (aXMLElement contentStringAt: #label);
		comment: (aXMLElement contentStringAt: #comment).
	resources at: rdfClass qualifiedName put: rdfClass.
]

{ #category : #private }
RdfExifVocabularyImporter >> addProperty: aXMLElement [
	"Add a RdfClass based on the supplied element"
	| rdfClass |

	rdfClass := RdfProperty new.
	rdfClass 
		name: (aXMLElement attributeAt: #'rdf:ID');
		namespace: self namespace;
		label: (aXMLElement contentStringAt: #label);
		comment: (aXMLElement contentStringAt: #comment).
	resources at: rdfClass qualifiedName put: rdfClass.
]
