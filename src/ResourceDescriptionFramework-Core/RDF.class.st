Class {
	#name : #RDF,
	#superclass : #RDFConvenience,
	#category : #'ResourceDescriptionFramework-Core-Factories'
}

{ #category : #accessing }
RDF class >> factory [
	^ RDFFactory default
]

{ #category : #accessing }
RDF class >> language [
	^ RDFLanguageFactory default
]

{ #category : #factory }
RDF class >> namedNode: aString [
	^ self factory namedNode: aString
]

{ #category : #factory }
RDF class >> object: aTerm [
	<return: #RDFObject>
	^ self factory object: aTerm
]

{ #category : #factory }
RDF class >> predicate: aTerm [
	<return: #RDFPredicate>
	^ self factory predicate: aTerm
]

{ #category : #factory }
RDF class >> subject: aTerm [
	<return: #RDFSubject>
	^ self factory subject: aTerm
]
