Class {
	#name : #RDFConvenience,
	#superclass : #Object,
	#classInstVars : [
		'knownPredicates'
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
RDFConvenience class >> findUniqueInstanceOf: aPredicateFullname [
	"Ask each of the subclasses for the unique instance matching the supplied string"

	self subclassesDo: [ :cls |
		(cls getUniqueInstanceOf: aPredicateFullname) ifNotNil: 
			[ :uniquePredicate | ^uniquePredicate ] ].
	^ nil.
]

{ #category : #private }
RDFConvenience class >> getUniqueInstanceOf: aPredicateFullname [

	^ (aPredicateFullname beginsWith: self factory prefix) 
		ifTrue: [ RDF predicate: (self factory namedNodeSuffix: aPredicateFullname asZnUrl lastPathSegment) ]
		ifFalse: [ nil ]
]

{ #category : #accessing }
RDFConvenience class >> knownPredicates [

	^ knownPredicates ifNil: [ knownPredicates := Dictionary new ]
]

{ #category : #initialization }
RDFConvenience class >> reset [ 
	
	knownPredicates := nil.
]

{ #category : #accessing }
RDFConvenience class >> uniqueInstanceOf: aPredicate [
	"Answer a unique instance of the supplied predicate, or nil if one can't be found"
	| uniquePredicate fullName |

	fullName := aPredicate fullName.
	self knownPredicates
		at: fullName
		ifPresent: [ :predicate | ^predicate ].

	uniquePredicate := self findUniqueInstanceOf: fullName.
	uniquePredicate ifNil: [ ^nil ].

	self knownPredicates
		at: fullName 
		put: uniquePredicate.
	^ uniquePredicate
]
