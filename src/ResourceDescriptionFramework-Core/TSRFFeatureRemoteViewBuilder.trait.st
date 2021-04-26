Trait {
	#name : #TSRFFeatureRemoteViewBuilder,
	#category : #'ResourceDescriptionFramework-Core-Storage'
}

{ #category : #private }
TSRFFeatureRemoteViewBuilder >> computeColorFromColorMap: aColorMap forTarget: anObject [
	| colorValues value |
	colorValues := aColorMap at: 'colors'.
	"(anObject isKindOf: RDFObject) ifFalse: [ ^ Color gray ]."
	
	value := self 
		computeObjectValueForPredicateMatching: (aColorMap at: 'value')
		forTarget: anObject.
	
	^ colorValues 
		at: value 
		ifPresent: [ :aColorString | Color fromHexString: aColorString ]
		ifAbsent: [ Color gray ]
]

{ #category : #private }
TSRFFeatureRemoteViewBuilder >> computeItemsFromQuery: aQuery forTarget: aTarget [
	| currentObject |
	currentObject := aTarget.
	aQuery do: [ :anOperation | 
		anOperation isString ifTrue: [ 
			currentObject := currentObject perform: anOperation asSymbol ].
		anOperation isDictionary ifTrue: [ 
			currentObject := self performQuery: anOperation on: currentObject. ] ].
	^ currentObject
]

{ #category : #private }
TSRFFeatureRemoteViewBuilder >> computeObjectValueForPredicateMatching: aQuery forTarget: anObject [
	| currentObject |
	
	currentObject := anObject.
	aQuery do: [ :anOperation | 
		currentObject ifNil: [ ^ '' ].
		anOperation isString ifTrue: [ 
			currentObject := currentObject perform: anOperation asSymbol ].
		anOperation isDictionary ifTrue: [ 
			currentObject := (self performFormatFor: anOperation on: currentObject) ] ].
	^ currentObject
]

{ #category : #private }
TSRFFeatureRemoteViewBuilder >> createColumnedListViewFrom: aViewData onTarget: anObject [
	| view |
	view := GtPhlowView empty columnedList.
	view 
		title: (aViewData at: 'title');
		priority: (aViewData at: 'priority');
		items: [ 
			| currentObject |
			currentObject := anObject.
			(aViewData at: 'items') do: [ :anOperation | 
				anOperation isString ifTrue: [ 
					currentObject := currentObject perform: anOperation asSymbol ].
				anOperation isDictionary ifTrue: [ 
					currentObject := self performQuery: anOperation on: currentObject. ] ].
			currentObject ].
	
	(aViewData at: 'columns') do: [ :aColumnData | 
		view 
			column: (aColumnData at: 'title') 
			do: [ :aColumn |
				aColumn 
					titleStencil: [ :titleText |
						self createHeaderElementFor: titleText asRopedText ];
					itemStencil: [ :anItem | 
						| currentObject |
						currentObject := anItem.
						(aColumnData at: 'computation') do: [ :anOperation | 
							anOperation isString ifTrue: [ 
								currentObject := currentObject perform: anOperation asSymbol ].
							anOperation isDictionary ifTrue: [ 
								currentObject := self performFormatFor: anOperation on: currentObject. ] ].
						self createListElementFor: (currentObject ifNil: ['']) ] ]	].
	
	^ view
		
]

{ #category : #private }
TSRFFeatureRemoteViewBuilder >> createColumnedTreeMapFrom: aViewData onTarget: anObject [
	| view |
	view := GtPhlowView empty explicit.
	view 
		title: (aViewData at: 'title');
		priority: (aViewData at: 'priority');
		stencil: [ 
			| dataLawElements items |
			
			items := (self computeItemsFromQuery: (aViewData at: 'items') forTarget: self).
			dataLawElements := (((items groupedBy: [ :anItem | self computeObjectValueForPredicateMatching: (aViewData at: 'grouping') forTarget: anItem ]) associations
				sortDescending: [ :assoc | assoc value size ])) 
				collect: [ :assoc |
					
					BlElement new
						layout: BlFrameLayout new;
						border: (BlBorder paint: Color white width: 1);
						background: ((assoc key isKindOf: RDFObject) 
							ifTrue: [ self 
								computeColorFromColorMap: (aViewData at: 'colorMap')
								forTarget: assoc  ]
							ifFalse: [ Color gray ]);
						constraintsDo: [ :c | 
							c horizontal matchParent.
							c vertical matchParent.
							c treemap weight: assoc value size  ];
						 addChild: (BrEditor new
							fitContent;
							text: ((assoc key isKindOf: RDFObject)
								ifTrue: [ self 
									computeObjectValueForPredicateMatching: (aViewData at: 'groupLabel')
									forTarget: assoc ]
								ifFalse: [ 'Undefined']);
							look: SoPolypolyParagraphLook) ].
			
			BlElement new 
				layout: GtGraphTreemapLayout squarify;
				constraintsDo: [ :constraints |
					constraints horizontal matchParent.
					constraints vertical matchParent ];
				margin: (BlInsets top: 5 left: 5 bottom: 5 right: 5);
				addChildren: dataLawElements;
				yourself ].
	^ view
		
]

{ #category : #'private - ui' }
TSRFFeatureRemoteViewBuilder >> createHeaderElementFor: aString [ 
	^ BrLabel new
		look:( SoPolypolyLabelLook new
			foreground: BrGlamorousColors defaultButtonTextColor);
		text: aString asRopedText
]

{ #category : #'private - ui' }
TSRFFeatureRemoteViewBuilder >> createListElementFor: aString [ 
	^ BrLabel new
		look: SoPolypolyListLabelLook;
		text: aString
]

{ #category : #private }
TSRFFeatureRemoteViewBuilder >> createListViewFrom: aViewData onTarget: anObject [
	| view |
	view := GtPhlowView empty list.
	view 
		title: (aViewData at: 'title');
		priority: (aViewData at: 'priority');
		items: [ 
			| currentObject |
			currentObject := anObject.
			
			(aViewData at: 'items') do: [ :anOperation | 
				
				anOperation isString ifTrue: [ 
					currentObject := currentObject perform: anOperation asSymbol ].
				anOperation isDictionary ifTrue: [ 
					currentObject := self performQuery: anOperation on: currentObject. ] ].
			currentObject ];
		itemFormat: [ :anItem |
			| currentObject |
			currentObject := anItem.
			(aViewData at: 'itemsFormat') do: [ :anOperation | 
				anOperation isString ifTrue: [ 
					currentObject := currentObject perform: anOperation asSymbol ].
				anOperation isDictionary ifTrue: [ 
					currentObject := self performFormatFor: anOperation on: currentObject. ]
				 ].
			currentObject ].
	^ view
		
]

{ #category : #private }
TSRFFeatureRemoteViewBuilder >> getJsObjectCode [
	self explicitRequirement
]

{ #category : #private }
TSRFFeatureRemoteViewBuilder >> getSerialisableViewDataForId: aViewId [
	| featureServer importer |
	featureServer := JSLinkApplication withDefaultSettings.
	[ 
		featureServer start.
		importer :=  featureServer newCommandFactory
			<< self getJsObjectCode;
			sendAndWait.
		^ importer newCommandFactory
			beImmediate;
			<< ('let GtViewedObject = require(''../gtoolkit/gt'');
let viewedObject = new GtViewedObject(this);
viewedObject.getViewDeclaration(''', aViewId, ''')');
			sendAndWait
	] ensure: [ featureServer stop ].
]

{ #category : #private }
TSRFFeatureRemoteViewBuilder >> getSerialisableViewForId: aViewId [
	| viewData viewType |
	viewData := self getSerialisableViewDataForId: aViewId.
	viewType := viewData at: 'type'.
	(viewType = 'list') ifTrue: [
		^ self createListViewFrom: viewData onTarget: self ].
	(viewType = 'columned-list') ifTrue: [
		^ self createColumnedListViewFrom: viewData onTarget: self ].
	(viewType = 'treemap') ifTrue: [
		^ self createColumnedTreeMapFrom: viewData onTarget: self ].
	
	^ nil
]

{ #category : #ui }
TSRFFeatureRemoteViewBuilder >> getSerialisableViewsData [
	| featureServer importer |
	featureServer := JSLinkApplication withDefaultSettings.
	[ 
		featureServer start.
		importer :=  featureServer newCommandFactory
			<< self getJsObjectCode;
			sendAndWait.
		^ importer newCommandFactory
			beImmediate;
			<< 'let GtViewedObject = require(''../gtoolkit/gt'');
let viewedObject = new GtViewedObject(this);
let viewsNames = viewedObject.getGtSerialisableViewMethodNames();
let viewsData = [];
viewsNames.forEach(viewName => {
  		viewsData.push(viewedObject.getViewDeclaration(viewName));
		  });
viewsData';
			sendAndWait
	] ensure: [ featureServer stop ].
]

{ #category : #ui }
TSRFFeatureRemoteViewBuilder >> gtSerialisableViewsListFor: aView [
	<gtView>
	^ aView list 
		title: 'Feature views';
		priority: 1005;
		items: [ self getSerialisableViewsData ];
		itemFormat: [ :data | data at: 'title' ];
		send: [ :data |
			SoSerialisableView new
				data: data ]
]

{ #category : #private }
TSRFFeatureRemoteViewBuilder >> performFormatFor: anOperation on: extractedSubject [
	| list |
	list := OrderedCollection streamContents: [ :aStream | 
		extractedSubject triplesWithSameSubjectInto: aStream ].
	
	^ list 
			detect: [ :aTripple |
				aTripple predicate fullName = (anOperation at: 'getPredicate') ]
			ifFound: [:aTripple |
				aTripple object ]
			ifNone: [ nil ]
]

{ #category : #private }
TSRFFeatureRemoteViewBuilder >> performQuery: aQuery on: currentObject [
	
	^ currentObject extractedSubjects select: [ :each | 
		| list |
		list := OrderedCollection streamContents: [ :aStream | 
			each triplesWithSameSubjectInto: aStream ].
		list anySatisfy: [ :aTriple |
			(aTriple realObject predicate fullName = (aQuery at: 'predicate')) and: [ 
				aTriple realObject object fullName = (aQuery at: 'object') ] ]]
]
