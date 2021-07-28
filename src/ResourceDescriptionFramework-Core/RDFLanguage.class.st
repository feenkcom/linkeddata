Class {
	#name : 'RDFLanguage',
	#superclass : 'RDFProtoObject',
	#instVars : [
		'tags'
	],
	#category : 'ResourceDescriptionFramework-Core-Model'
}

{ #category : 'accessing' }
RDFLanguage class >> factory [
	^ RDFLanguageFactory default
]

{ #category : 'gt-extension' }
RDFLanguage >> gtTagsFor: aView [
	<gtView>
	self tags ifNil: [ ^ aView empty ].
	^ aView list
		title: 'Language Specification';
		items: [ self tags ]
]

{ #category : 'initialization' }
RDFLanguage >> initialize [
	super initialize.
	tags := #( 'en' ).
]

{ #category : 'printing' }
RDFLanguage >> printOn: aStream [
	self tags ifNil: [ ^ super printOn: aStream ].
	self tags 
		do: [ :eachTag | aStream nextPutAll: eachTag ] 
		separatedBy: [ aStream nextPut: $- ]
]

{ #category : 'accessing' }
RDFLanguage >> tag: aString [
	self tags: (Array with: aString)
]

{ #category : 'accessing' }
RDFLanguage >> tags [
	<return: #Array of: #String>
	^ tags
]

{ #category : 'accessing' }
RDFLanguage >> tags: anArray [
	self 
		assert: [ anArray isArray and: [ anArray isNotEmpty ] ] 
		description: [ 'Language identifier must be non-empty array' ].
	self 
		assert: [ anArray allSatisfy: [ :eachTag | eachTag isString and: [ eachTag isNotEmpty ] ] ] 
		description: [ 'Language identifier parts must be non-empty strings' ].
	tags := anArray
]
