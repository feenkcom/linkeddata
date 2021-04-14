Class {
	#name : #RDFStore,
	#superclass : #Object,
	#category : #'ResourceDescriptionFramework-Core-Storage'
}

{ #category : #factory }
RDFStore class >> jena [

	^ RDFJenaStore new
]

{ #category : #factory }
RDFStore class >> simple [
	^ RDFSimpleCollectionStore new
]

{ #category : #adding }
RDFStore >> addTriple: aRDFTriple [
	self subclassResponsibility
]

{ #category : #enumerating }
RDFStore >> resourceForSubject: aSubject withSphere: aRDFSphere [
	<return: #RDFResourceWithSphere>
	
	^ RDFResourceWithSphere new 
		subject: aSubject;
		sphere: aRDFSphere;
		triples: (self triplesForSubject: aSubject forSphere: aRDFSphere)
]

{ #category : #enumerating }
RDFStore >> triplesForPredicate: aPredicate [
	<return: #RDFList>

	^ RDFList new collection: (self collection 
		inject: OrderedCollection new
		into: [ :aList :eachTriple |
			(eachTriple predicate = aPredicate) ifTrue: [
				aList add: eachTriple ]. aList ])
]

{ #category : #enumerating }
RDFStore >> triplesForSubject: aSubject [
	<return: #RDFList>

	^ RDFList new collection: (self collection 
		inject: OrderedCollection new
		into: [ :aList :eachTriple |
			(eachTriple subject = aSubject) ifTrue: [
				aList add: eachTriple ]. aList ])
]

{ #category : #enumerating }
RDFStore >> triplesForSubject: aSubject forSphere: aRDFSphere [
	<return: #RDFList>

	^ RDFList new collection: ((
		self triplesForSubject: aSubject) collection select: [ :aTriplet |
			aRDFSphere isInterestedInTriplet: aTriplet ])
]
