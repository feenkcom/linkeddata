Class {
	#name : #RdfDataType,
	#superclass : #RdfProperty,
	#instVars : [
		'parser',
		'printer'
	],
	#category : #'ResourceDescriptionFramework-Core-Model'
}

{ #category : #accessing }
RdfDataType >> parser [
	^ parser
]

{ #category : #accessing }
RdfDataType >> parser: anObject [
	parser := anObject
]

{ #category : #accessing }
RdfDataType >> printer [
	^ printer
]

{ #category : #accessing }
RdfDataType >> printer: anObject [
	printer := anObject
]
