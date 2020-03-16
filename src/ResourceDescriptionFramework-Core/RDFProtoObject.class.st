Class {
	#name : #RDFProtoObject,
	#superclass : #Object,
	#traits : 'TGtAssert',
	#classTraits : 'TGtAssert classTrait',
	#category : #'ResourceDescriptionFramework-Core-Model'
}

{ #category : #printing }
RDFProtoObject >> printShortOn: aStream [
	self printOn: aStream
]
