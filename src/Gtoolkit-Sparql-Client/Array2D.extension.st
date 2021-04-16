Extension { #name : #Array2D }

{ #category : #'*Gtoolkit-Sparql-Client' }
Array2D >> rowsCollect: aBlock [ 
	"Collect the result of evaluating aBlock with each row of the receiver"

	^ Array streamContents: [ :stream |
		1 to: numberOfRows do: [ :row |
			stream nextPut: (aBlock value: (self atRow: row)) ] ]
]

{ #category : #'*Gtoolkit-Sparql-Client' }
Array2D >> rowsDo: aBlock [ 
	"Evaluate aBlock with each row of the receiver"

	1 to: numberOfRows do: [ :row |
		aBlock value: (self atRow: row) ]
]
