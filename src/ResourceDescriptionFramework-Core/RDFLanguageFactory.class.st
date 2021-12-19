Class {
	#name : #RDFLanguageFactory,
	#superclass : #RDFProtoFactory,
	#category : 'ResourceDescriptionFramework-Core-Factories'
}

{ #category : #factory }
RDFLanguageFactory >> en [
	^ self language: 'en'
]

{ #category : #factory }
RDFLanguageFactory >> language [
	^ RDFLanguage new
]

{ #category : #factory }
RDFLanguageFactory >> language: aString [
	<return: #RDFLanguage>
	^ self language tag: aString
]
