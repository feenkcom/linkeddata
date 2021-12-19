Class {
	#name : #RDFStore,
	#superclass : #Object,
	#instVars : [
		'dbMutex'
	],
	#category : 'ResourceDescriptionFramework-Core-Storage'
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

{ #category : #adding }
RDFStore >> addTriples: aCollection [

	self subclassResponsibility
]

{ #category : #accessing }
RDFStore >> datasetUrl [ 

	^ self subclassResponsibility
]

{ #category : #deleting }
RDFStore >> deleteWithSubject: aRdfSubject predicate: aRdfPredicate [

	self subclassResponsibility 
]

{ #category : #adding }
RDFStore >> flush [ 
	"Flush the receiver's write cache.
	Subclasses will override this as required."
]

{ #category : #initialization }
RDFStore >> initialize [ 

	super initialize.
	dbMutex := Semaphore forMutualExclusion.
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
RDFStore >> triplesForSubject: aSubject forSphere: aRDFSphere [
	<return: #RDFList>

	^ RDFList new collection: ((
		self triplesWithSubject: aSubject) collection select: [ :aTriplet |
			aRDFSphere isInterestedInTriplet: aTriplet ])
]

{ #category : #querying }
RDFStore >> triplesForSubjectIRI: aString [ 
	"Answer the collection of triples for the supplied subject IRI"
	<return: #RDFList>

	^ self triplesWithSubject: (RDFTripleBuilder new subjectIRI: aString)
]

{ #category : #enumerating }
RDFStore >> triplesWithPredicate: aPredicate [
	<return: #RDFList>

	^ RDFList new collection: (self collection 
		inject: OrderedCollection new
		into: [ :aList :eachTriple |
			(eachTriple predicate = aPredicate) ifTrue: [
				aList add: eachTriple ]. aList ])
]

{ #category : #enumerating }
RDFStore >> triplesWithSubject: aSubject [
	<return: #RDFList>

	^ RDFList new collection: (self collection 
		inject: OrderedCollection new
		into: [ :aList :eachTriple |
			(eachTriple subject = aSubject) ifTrue: [
				aList add: eachTriple ]. aList ])
]

{ #category : #adding }
RDFStore >> tsAddTriple: aRdfTriple [
	"Add the supplied triple, allowing for multi-threading"

	dbMutex critical: 
		[ self addTriple: aRdfTriple ]
]

{ #category : #adding }
RDFStore >> tsAddTriples: aCollection [
	"Add the supplied triples, allowing for multi-threading"

	dbMutex critical: 
		[ self addTriples: aCollection ]
]

{ #category : #adding }
RDFStore >> tsFlush [

	dbMutex critical: [ self flush ]
]

{ #category : #adding }
RDFStore >> tsUpdate: aString [
	"Evalute the supplied update string, allowing for multi-threading"

	dbMutex critical: 
		[ self update: aString ]
]
