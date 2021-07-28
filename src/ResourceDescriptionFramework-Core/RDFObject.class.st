Class {
	#name : 'RDFObject',
	#superclass : 'RDFTriplePart',
	#category : 'ResourceDescriptionFramework-Core-Model'
}

{ #category : 'testing' }
RDFObject >> isObject [

	^ true
]

{ #category : 'accessing' }
RDFObject >> name [
	^ 'Object'
]
