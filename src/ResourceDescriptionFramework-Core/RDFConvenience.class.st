Class {
	#name : #RDFConvenience,
	#superclass : #Object,
	#classVars : [
		'KnownPredicates'
	],
	#category : #'ResourceDescriptionFramework-Core-Factories'
}

{ #category : #cleanup }
RDFConvenience class >> cleanAll [
	<script>
	self withAllSubclassesDo: #reset 
]

{ #category : #factory }
RDFConvenience class >> factory [ 

	^ self subclassResponsibility 
]

{ #category : #accessing }
RDFConvenience class >> findUniquePredicateFor: aPredicateFullname [
	"Ask each of the subclasses for the unique instance matching the supplied string"

	self subclassesDo: [ :cls |
		(cls getUniquePredicateFor: aPredicateFullname) ifNotNil: 
			[ :uniquePredicate | ^uniquePredicate ] ].
	^ nil.
]

{ #category : #private }
RDFConvenience class >> getUniquePredicateFor: aPredicateFullname [

	^ (aPredicateFullname beginsWith: self factory prefix) 
		ifTrue: [ RDF predicate: (self factory namedNodeSuffix: aPredicateFullname asZnUrl lastPathSegment) ]
		ifFalse: [ nil ]
]

{ #category : #accessing }
RDFConvenience class >> knownPredicates [

	^ KnownPredicates ifNil: [ KnownPredicates := Dictionary new ]
]

{ #category : #initialization }
RDFConvenience class >> reset [ 
	
	KnownPredicates := nil.
]
