Class {
	#name : #RDFConvenience,
	#superclass : #Object,
	#classVars : [
		'KnownIRIs',
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

{ #category : #private }
RDFConvenience class >> getKnownIRIs [
	| dictionary iri |

	dictionary := Dictionary new.
	self subclassesDo: [ :cls |
		cls iriNames do: [ :each |
			iri := each value: cls.
			dictionary at: iri fullName put: iri ] ].
	^ dictionary
]

{ #category : #accessing }
RDFConvenience class >> iriAt: aString [

	^ self knownIRIs at: aString ifAbsent: [ 
		(self shortNamedNodeFor: aString)
			ifNil: [ 	RDFNamedNode new value: aString ]
			ifNotNil: [ :node | self knownIRIs at: node fullName put: node ] ]
]

{ #category : #accessing }
RDFConvenience class >> iriNames [
	"Answer the collection of known IRI names for the receiver's namespace"

	^ self subclassResponsibility
]

{ #category : #accessing }
RDFConvenience class >> knownIRIs [

	^ KnownIRIs ifNil: [ KnownIRIs := self getKnownIRIs ]
]

{ #category : #accessing }
RDFConvenience class >> knownPredicates [

	^ KnownPredicates ifNil: [ KnownPredicates := Dictionary new ]
]

{ #category : #accessing }
RDFConvenience class >> predicateAt: aString [ 

	^ self knownPredicates 
		at: aString
		ifAbsentPut: [ RDF predicate: (self iriAt: aString) ]
]

{ #category : #initialization }
RDFConvenience class >> reset [ 
	<script>

	KnownPredicates := nil.
	KnownIRIs := nil.
]

{ #category : #private }
RDFConvenience class >> shortNamedNodeFor: aString [ 
	| prefix |

	self subclassesDo: [ :cls |
		prefix := cls factory prefix.
		(aString beginsWith: prefix) ifTrue: 
			[ ^ (cls factory namedNodeSuffix: 
				(aString copyFrom: prefix size + 1 to: aString size)) ] ]

]
