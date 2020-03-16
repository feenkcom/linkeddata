Class {
	#name : #RDF,
	#superclass : #RDFConvenience,
	#category : #'ResourceDescriptionFramework-Core-Factories'
}

{ #category : #accessing }
RDF class >> factory [
	^ RDFFactory default
]

{ #category : #factory }
RDF class >> namedNode: aString [
	^ self factory namedNode: aString
]

{ #category : #factory }
RDF class >> predicate: aTerm [
	<return: #RDFPredicate>
	^ self factory predicate: aTerm
]
