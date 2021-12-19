Class {
	#name : #RDFTerm,
	#superclass : #RDFProtoObject,
	#instVars : [
		'value'
	],
	#category : 'ResourceDescriptionFramework-Core-Model'
}

{ #category : #accessing }
RDFTerm class >> classForType: aString [
	"Answer the subclass that represents the supplied type name"

	^ self allSubclasses detect: [ :cls | cls typeName = aString ]
]

{ #category : #'instance creation' }
RDFTerm class >> fromJsonDictionary: aDictionary [
	"Answer an instance of the appropriate subclass.
	aDictionary follows the structure defined at https://www.w3.org/TR/sparql11-results-json/"

	aDictionary ifNil: [ ^ nil ].
	^ (self classForType: (aDictionary at: #type)) fromJsonDictionary: aDictionary
]

{ #category : #accessing }
RDFTerm class >> typeName [ 
	"Answer the type the receiver represents.
	Subclasses will override this as appropriate"

	^ nil
]

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
		self value = aRDFTerm value ]
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
	^ self class hash bitXor: self value hash
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

{ #category : #printing }
RDFTerm >> printSparqlOn: aStream [
	"Print the SPARQL syntax encoding of the receiver on the supplied stream.
	See: https://www.w3.org/TR/2013/REC-sparql11-query-20130321"

	self subclassResponsibility 
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
