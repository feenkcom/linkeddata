Class {
	#name : 'RdfObjectValueParsers',
	#superclass : 'Object',
	#category : 'ResourceDescriptionFramework-Core-Helpers'
}

{ #category : 'parsing' }
RdfObjectValueParsers class >> parseBoolean: aString [ 
	| boolean |

	boolean := aString = #true.
	boolean ifFalse: [ self assert: aString = #false description: 'invalid boolean value' ].
	^ boolean
]

{ #category : 'parsing' }
RdfObjectValueParsers class >> parseDate: aString [ 

	^ Date readFrom: aString readStream
]

{ #category : 'parsing' }
RdfObjectValueParsers class >> parseDateTime: aString [ 

	^ DateAndTime readFrom: aString readStream
]

{ #category : 'parsing' }
RdfObjectValueParsers class >> parseDecimal: aString [ 

	^ ScaledDecimal readFrom: aString
]

{ #category : 'parsing' }
RdfObjectValueParsers class >> parseDouble: aString [ 

	^ aString asLowercase asNumber
]

{ #category : 'parsing' }
RdfObjectValueParsers class >> parseInteger: aString [ 

	^ aString asInteger
]
