Class {
	#name : #RDFTweetSphere,
	#superclass : #RDFSphere,
	#category : #'ResourceDescriptionFramework-Examples'
}

{ #category : #'as yet unclassified' }
RDFTweetSphere >> buildOverviewElementFor: theTweetTriples [
	"Receives tweets as triple objects"
	| container |
	container := BlElement new 
		layout: BlLinearLayout vertical;
		constraintsDo: [ :c | 
			c horizontal exact: 300.
			c vertical fitContent ];
		background: Color white	;
		look: BrShadowLook new;
		margin: (BlInsets all: 10).
	container addChild: (BrEditor new 
		margin: (BlInsets all: 10);
		look: BrGlamorousRegularEditorLook new;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical fitContent ];
		text: (self textFor: theTweetTriples) asRopedText).
	container addChild: (BlElement new
		constraintsDo: [:c | c horizontal matchParent. c vertical fitContent];
		layout: BlLinearLayout horizontal;
		margin: (BlInsets all: 10);
		addChild: (BlTextElement new text: (((self datePublishedFor: theTweetTriples) asLocalStringYMDHM asRopedText sociatorRegularFont; fontSize: 10; foreground: Color gray)))).
	^ container
]

{ #category : #accessing }
RDFTweetSphere >> datePublishedFor: theTweetTriples [
	| aTerm |
	aTerm := SCHEMA datePublished.
	^ theTweetTriples collection 
		detect: [ :eachTriple | eachTriple predicate term = aTerm ]
		ifFound: [ :aTriple | aTriple object term value ]
		ifNone: [ DateAndTime now ]
]

{ #category : #'as yet unclassified' }
RDFTweetSphere >> gtExplicitViewFor: aView triples: aList [
	<gtSphereView>
	^ aView explicit 
		title: 'View';
		stencil: [ self buildOverviewElementFor: aList ]
]

{ #category : #'as yet unclassified' }
RDFTweetSphere >> gtSphereViewsFor: aView forTriples: aList [
	^ { self gtExplicitViewFor: aView triples: aList }
]

{ #category : #accessing }
RDFTweetSphere >> textFor: theTweetTriples [
	| aTerm |
	aTerm := SCHEMA text.
	^ theTweetTriples collection 
		detect: [ :eachTriple | eachTriple predicate term = aTerm ]
		ifFound: [ :aTriple | aTriple object term value ]
		ifNone: [ '<should be there>' ]
]
