Trait {
	#name : #TSRFFeatureRemoteViewBuilder,
	#category : #'ResourceDescriptionFramework-Core-Storage'
}

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
	
	^ nil
]

{ #category : #private }
TSRFFeatureRemoteViewBuilder >> performFormatFor: anOperation on: extractedSubject [
	| list |
	list := OrderedCollection streamContents: [ :aStream | 
		extractedSubject triplesWithSameSubjectInto: aStream ].
	self halt.
	^ list 
			detect: [ :aTripple |
				aTripple predicate fullName = (anOperation at: 'getPredicate') ]
			ifNone: [ 'a' ]
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