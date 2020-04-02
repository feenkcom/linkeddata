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

{ #category : #accessing }
RDFTerm >> description [
	^ String streamContents: [ :aStream | 
		self printDescriptionOn: aStream ]
]

{ #category : #comparing }
RDFTerm >> equals: aRDFTerm [
	<return: #Boolean>
	^ self class = aRDFTerm class and: [ 
		self termType = aRDFTerm termType and: [ 
			self value = aRDFTerm value ] ]
]

{ #category : #accessing }
RDFTerm >> fullName [
	^ String streamContents: [ :aStream | 
		self printFullNameOn: aStream ]
]

{ #category : #accessing }
RDFTerm >> fullNameWithDataType [
	^ String streamContents: [ :aStream | 
		self printFullNameWithDataTypeOn: aStream ]
]

{ #category : #'gt-extension' }
RDFTerm >> gtValueFor: aView [
	^ self gtPrintFor: aView
]

{ #category : #comparing }
RDFTerm >> hash [
	^ (self class hash 
		bitXor: self termType hash)
			bitXor: self value hash
]

{ #category : #printing }
RDFTerm >> printDescriptionOn: aStream [
	self printFullNameOn: aStream
]

{ #category : #printing }
RDFTerm >> printFullNameOn: aStream [
	self printOn: aStream
]

{ #category : #printing }
RDFTerm >> printFullNameWithDataTypeOn: aStream [
	self printFullNameOn: aStream
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
