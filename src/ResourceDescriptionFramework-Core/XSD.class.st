Class {
	#name : #XSD,
	#superclass : #RDFConvenience,
	#category : 'ResourceDescriptionFramework-Core-Factories'
}

{ #category : #factory }
XSD class >> boolean [
	^ self factory boolean
]

{ #category : #factory }
XSD class >> date [
	^ self factory date
]

{ #category : #factory }
XSD class >> dateTime [
	^ self factory dateTime
]

{ #category : #factory }
XSD class >> decimal [
	^ self factory decimal
]

{ #category : #factory }
XSD class >> double [
	^ self factory double
]

{ #category : #accessing }
XSD class >> factory [
	^ XSDFactory default
]

{ #category : #factory }
XSD class >> integer [
	^ self factory integer
]

{ #category : #accessing }
XSD class >> iriNames [

	^ #(boolean date dateTime decimal double integer string)
]

{ #category : #testing }
XSD class >> isDeprecated [ 
	"XSD is deprecated, RdfVocabularies should be used instead"
	
	^ true
]

{ #category : #factory }
XSD class >> namedNode: aString [
	^ self factory namedNode: aString
]

{ #category : #parsing }
XSD class >> parseBoolean: aString [ 
	| boolean |

	boolean := aString = #true.
	boolean ifFalse: [ self assert: aString = #false description: 'invalid boolean value' ].
	^ boolean
]

{ #category : #parsing }
XSD class >> parseDate: aString [ 

	^ Date readFrom: aString readStream
]

{ #category : #parsing }
XSD class >> parseDateTime: aString [ 

	^ DateAndTime readFrom: aString readStream
]

{ #category : #parsing }
XSD class >> parseDecimal: aString [ 

	^ ScaledDecimal readFrom: aString
]

{ #category : #parsing }
XSD class >> parseDouble: aString [ 

	^ aString asLowercase asNumber
]

{ #category : #parsing }
XSD class >> parseInteger: aString [ 

	^ aString asInteger
]

{ #category : #factory }
XSD class >> string [
	^ self factory string
]
