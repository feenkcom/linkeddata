Class {
	#name : #RDFTerm,
	#superclass : #RDFProtoObject,
	#instVars : [
		'value'
	],
	#category : #'ResourceDescriptionFramework-Core-Model'
}

{ #category : #comparing }
RDFTerm >> = aRDFTerm [
	^ self equals: aRDFTerm
]

{ #category : #comparing }
RDFTerm >> equals: aRDFTerm [
	<return: #Boolean>
	^ self class = aRDFTerm class and: [ 
		self termType = aRDFTerm termType and: [ 
			self value = aRDFTerm value ] ]
]

{ #category : #accessing }
RDFTerm >> termType [
	<return: #RDFTermType>
	^ self subclassResponsibility
]

{ #category : #accessing }
RDFTerm >> value [
	^ value
]

{ #category : #accessing }
RDFTerm >> value: anObject [
	value := anObject
]
