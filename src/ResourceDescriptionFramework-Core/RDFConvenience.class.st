Class {
	#name : #RDFConvenience,
	#superclass : #Object,
	#classInstVars : [
		'knownPredicates'
	],
	#category : #'ResourceDescriptionFramework-Core-Factories'
}

{ #category : #accessing }
RDFConvenience class >> findUniqueInstanceOf: aPredicateFullname [
	"Ask each of the subclasses for the unique instance matching the supplied string"

	self subclassesDo: [ :cls |
		(cls getUniqueInstanceOf: aPredicateFullname) ifNotNil: 
			[ :uniquePredicate | ^uniquePredicate ] ].
	^ nil.
]

{ #category : #'as yet unclassified' }
RDFConvenience class >> getUniqueInstanceOf: aPredicateFullname [

	^ (aPredicateFullname beginsWith: self factory prefix) 
		ifTrue: [ self factory namedNodeSuffix: aPredicateFullname asZnUrl lastPathSegment ]
		ifFalse: [ nil ]
]

{ #category : #accessing }
RDFConvenience class >> knownPredicates [

	^ knownPredicates ifNil: [ knownPredicates := Dictionary new ]
]

{ #category : #initialization }
RDFConvenience class >> reset [ 
	<script>
	
	knownPredicates := nil.
]

{ #category : #accessing }
RDFConvenience class >> uniqueInstanceOf: aPredicateFullname [
	"Answer a unique instance of the supplied predicate, or nil if one can't be found"
	| uniquePredicate |

	self knownPredicates
		at: aPredicateFullname
		ifPresent: [ :predicate | ^predicate ].

	uniquePredicate := self findUniqueInstanceOf: aPredicateFullname.
	uniquePredicate ifNil: [ ^nil ].

	self knownPredicates
		at: aPredicateFullname 
		put: uniquePredicate.
	^ uniquePredicate
]
