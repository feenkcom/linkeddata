Trait {
	#name : #TRDFExamples,
	#category : #'ResourceDescriptionFramework-Examples'
}

{ #category : #'examples - basic' }
TRDFExamples >> objectWith: aTerm [
	<gtExample>
	| aSubject |
	aSubject := RDF object: aTerm.
	self assert: aSubject term equals: aTerm.
	^ aSubject
]

{ #category : #'examples - basic' }
TRDFExamples >> predicateWith: aTerm [
	<gtExample>
	| aPredicate |
	aPredicate := RDF predicate: aTerm.
	self assert: aPredicate term equals: aTerm.
	^ aPredicate
]

{ #category : #'examples - basic' }
TRDFExamples >> subjectWith: aTerm [
	<gtExample>
	| aSubject |
	aSubject := RDF subject: aTerm.
	self assert: aSubject term equals: aTerm.
	^ aSubject
]
