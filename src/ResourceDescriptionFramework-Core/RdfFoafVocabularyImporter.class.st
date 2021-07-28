Class {
	#name : 'RdfFoafVocabularyImporter',
	#superclass : 'RdfVocabularyImporter',
	#category : 'ResourceDescriptionFramework-Core-Importers'
}

{ #category : 'private' }
RdfFoafVocabularyImporter >> addClass: aXMLElement [
	"Add a RdfClass based on the supplied element"
	| rdfClass className |

	(#(unstable archaic) includes: (aXMLElement attributeAt: #'vs:term_status')) ifTrue: 
		[ ^ self ].

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

{ #category : 'private' }
RdfFoafVocabularyImporter >> addProperty: aXMLElement [
	"Add a RdfClass based on the supplied element"
	| rdfClass propertyName |

	(#(unstable archaic) includes: (aXMLElement attributeAt: #'vs:term_status')) ifTrue: 
		[ ^ self ].

	propertyName := aXMLElement attributeAt: #'rdf:about'.
	propertyName := propertyName copyFrom: self namespace iri size + 1 to: propertyName size.
	rdfClass := RdfProperty new.
	rdfClass 
		name: propertyName;
		namespace: self namespace;
		label: (aXMLElement attributeAt: #'rdfs:label');
		comment: (aXMLElement attributeAt: #'rdfs:comment').
	resources at: rdfClass qualifiedName put: rdfClass.
]
