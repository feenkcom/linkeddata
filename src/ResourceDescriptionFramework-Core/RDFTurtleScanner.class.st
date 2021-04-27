Class {
	#name : #RDFTurtleScanner,
	#superclass : #SmaCCScanner,
	#category : #'ResourceDescriptionFramework-Core-Parsers'
}

{ #category : #'generated-initialization' }
RDFTurtleScanner class >> initializeKeywordMap [
	keywordMap := Dictionary new.
	#(#(21 '@base' 6) #(21 '@prefix' 7))
		do: [ :each | 
			(keywordMap at: each first ifAbsentPut: [ Dictionary new ])
				at: (each at: 2)
				put: each last ].
	^ keywordMap
]

{ #category : #generated }
RDFTurtleScanner >> emptySymbolTokenId [
	^ 57
]

{ #category : #generated }
RDFTurtleScanner >> errorTokenId [
	^ 58
]

{ #category : #generated }
RDFTurtleScanner >> scan1 [
	[ self step.
	currentCharacter == $"
		ifTrue: [ ^ self recordAndReportMatch: #(24) ].
	currentCharacter == $\
		ifTrue: [ ^ self scan2 ].
	currentCharacter <= Character tab
		or: [ (currentCharacter between: Character pageUp and: Character newPage)
				or: [ (currentCharacter between: (Character value: 14) and: $!)
						or: [ (currentCharacter between: $# and: $[)
								or: [ currentCharacter >= $] ] ] ] ] ] whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
RDFTurtleScanner >> scan10 [
	[ self step.
	currentCharacter == $'
		ifTrue: [ ^ self scan11 ].
	currentCharacter == $\
		ifTrue: [ ^ self scan12 ].
	'"^' includes: currentCharacter ] whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
RDFTurtleScanner >> scan11 [
	(self scanForString: '''''')
		ifTrue: [ [ self recordMatch: #(22).
			self step.
			currentCharacter == $' ] whileTrue ].
	currentCharacter == $\
		ifTrue: [ ^ self scan12 ].
	('"^' includes: currentCharacter)
		ifTrue: [ ^ self scan10 ].
	^ self reportLastMatch
]

{ #category : #generated }
RDFTurtleScanner >> scan12 [
	[ self step.
	currentCharacter == $'
		ifTrue: [ ^ self scan11 ].
	currentCharacter == $U
		ifTrue: [ self step.
			(currentCharacter isDigit
				or: [ (currentCharacter between: $A and: $F)
						or: [ currentCharacter between: $a and: $f ] ])
				ifTrue: [ self step.
					(currentCharacter isDigit
						or: [ (currentCharacter between: $A and: $F)
								or: [ currentCharacter between: $a and: $f ] ])
						ifTrue: [ self step.
							(currentCharacter isDigit
								or: [ (currentCharacter between: $A and: $F)
										or: [ currentCharacter between: $a and: $f ] ])
								ifTrue: [ self step.
									(currentCharacter isDigit
										or: [ (currentCharacter between: $A and: $F)
												or: [ currentCharacter between: $a and: $f ] ])
										ifTrue: [ ^ self scan13 ] ] ] ].
			^ self reportLastMatch ].
	currentCharacter == $\ ] whileTrue.
	currentCharacter == $u
		ifTrue: [ ^ self scan13 ].
	('"^bfnrt' includes: currentCharacter)
		ifTrue: [ ^ self scan10 ].
	^ self reportLastMatch
]

{ #category : #generated }
RDFTurtleScanner >> scan13 [
	self step.
	(currentCharacter isDigit
		or: [ (currentCharacter between: $A and: $F)
				or: [ currentCharacter between: $a and: $f ] ])
		ifTrue: [ self step.
			(currentCharacter isDigit
				or: [ (currentCharacter between: $A and: $F)
						or: [ currentCharacter between: $a and: $f ] ])
				ifTrue: [ self step.
					(currentCharacter isDigit
						or: [ (currentCharacter between: $A and: $F)
								or: [ currentCharacter between: $a and: $f ] ])
						ifTrue: [ self step.
							(currentCharacter isDigit
								or: [ (currentCharacter between: $A and: $F)
										or: [ currentCharacter between: $a and: $f ] ])
								ifTrue: [ ^ self scan10 ] ] ] ].
	^ self reportLastMatch
]

{ #category : #generated }
RDFTurtleScanner >> scan14 [
	[ self recordMatch: #(15).
	self step.
	currentCharacter isDigit ] whileTrue.
	('Ee' includes: currentCharacter)
		ifTrue: [ ^ self scan15 ].
	^ self reportLastMatch
]

{ #category : #generated }
RDFTurtleScanner >> scan15 [
	self step.
	currentCharacter isDigit
		ifTrue: [ [ self recordMatch: #(15).
			self step.
			currentCharacter isDigit ] whileTrue.
			^ self reportLastMatch ].
	('+-' includes: currentCharacter)
		ifTrue: [ self step.
			currentCharacter isDigit
				ifTrue: [ [ self recordMatch: #(15).
					self step.
					currentCharacter isDigit ] whileTrue ] ].
	^ self reportLastMatch
]

{ #category : #generated }
RDFTurtleScanner >> scan16 [
	[ self recordMatch: #(15).
	self step.
	currentCharacter == $.
		ifTrue: [ self step.
			currentCharacter isDigit
				ifTrue: [ ^ self scan14 ].
			('Ee' includes: currentCharacter)
				ifTrue: [ ^ self scan15 ].
			^ self reportLastMatch ].
	currentCharacter isDigit ] whileTrue.
	('Ee' includes: currentCharacter)
		ifTrue: [ ^ self scan15 ].
	^ self reportLastMatch
]

{ #category : #generated }
RDFTurtleScanner >> scan17 [
	self recordMatch: #(19 20).
	self step.
	currentCharacter == $%
		ifTrue: [ ^ self scan18 ].
	currentCharacter == $\
		ifTrue: [ ^ self scan20 ].
	((currentCharacter between: $0 and: $:)
		or: [ (currentCharacter between: $A and: $Z)
				or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ] ])
		ifTrue: [ ^ self scan19 ].
	^ self reportLastMatch
]

{ #category : #generated }
RDFTurtleScanner >> scan18 [
	self step.
	(currentCharacter isDigit
		or: [ (currentCharacter between: $A and: $F)
				or: [ currentCharacter between: $a and: $f ] ])
		ifTrue: [ self step.
			(currentCharacter isDigit
				or: [ (currentCharacter between: $A and: $F)
						or: [ currentCharacter between: $a and: $f ] ])
				ifTrue: [ ^ self scan19 ] ].
	^ self reportLastMatch
]

{ #category : #generated }
RDFTurtleScanner >> scan19 [
	[ self recordMatch: #(20).
	self step.
	currentCharacter == $%
		ifTrue: [ ^ self scan18 ].
	currentCharacter == $.
		ifTrue: [ [ self step.
			currentCharacter == $%
				ifTrue: [ ^ self scan18 ].
			currentCharacter == $. ] whileTrue.
			currentCharacter == $\
				ifTrue: [ ^ self scan20 ].
			(currentCharacter == $-
				or: [ (currentCharacter between: $0 and: $:)
						or: [ (currentCharacter between: $A and: $Z)
								or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ] ] ])
				ifTrue: [ ^ self scan19 ].
			^ self reportLastMatch ].
	currentCharacter == $\
		ifTrue: [ ^ self scan20 ].
	currentCharacter == $-
		or: [ (currentCharacter between: $0 and: $:)
				or: [ (currentCharacter between: $A and: $Z)
						or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ] ] ] ]
		whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
RDFTurtleScanner >> scan2 [
	self step.
	currentCharacter == $U
		ifTrue: [ self step.
			(currentCharacter isDigit
				or: [ (currentCharacter between: $A and: $F)
						or: [ currentCharacter between: $a and: $f ] ])
				ifTrue: [ self step.
					(currentCharacter isDigit
						or: [ (currentCharacter between: $A and: $F)
								or: [ currentCharacter between: $a and: $f ] ])
						ifTrue: [ self step.
							(currentCharacter isDigit
								or: [ (currentCharacter between: $A and: $F)
										or: [ currentCharacter between: $a and: $f ] ])
								ifTrue: [ self step.
									(currentCharacter isDigit
										or: [ (currentCharacter between: $A and: $F)
												or: [ currentCharacter between: $a and: $f ] ])
										ifTrue: [ ^ self scan3 ] ] ] ].
			^ self reportLastMatch ].
	currentCharacter == $u
		ifTrue: [ ^ self scan3 ].
	('"''\bfnrt' includes: currentCharacter)
		ifTrue: [ ^ self scan1 ].
	^ self reportLastMatch
]

{ #category : #generated }
RDFTurtleScanner >> scan20 [
	self step.
	(currentCharacter == $!
		or: [ (currentCharacter between: $# and: $/)
				or: [ (';=' includes: currentCharacter)
						or: [ (currentCharacter between: $? and: $@)
								or: [ '_~' includes: currentCharacter ] ] ] ])
		ifTrue: [ ^ self scan19 ].
	^ self reportLastMatch
]

{ #category : #generated }
RDFTurtleScanner >> scan21 [
	self step.
	((currentCharacter between: $0 and: $9)
		or: [ (currentCharacter between: $A and: $Z)
				or: [ currentCharacter between: $a and: $z ] ])
		ifTrue: [ [ self recordMatch: #(21).
			self step.
			currentCharacter == $-
				ifTrue: [ ^ self scan21 ].
			(currentCharacter between: $0 and: $9)
				or: [ (currentCharacter between: $A and: $Z)
						or: [ currentCharacter between: $a and: $z ] ] ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
RDFTurtleScanner >> scan22 [
	[ self step.
	currentCharacter == $.
		ifTrue: [ ^ self scan23 ].
	currentCharacter == $:
		ifTrue: [ ^ self scan17 ].
	currentCharacter == $-
		or: [ (currentCharacter between: $0 and: $9)
				or: [ (currentCharacter between: $A and: $Z)
						or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ] ] ] ]
		whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
RDFTurtleScanner >> scan23 [
	[ self step.
	currentCharacter == $. ] whileTrue.
	(currentCharacter == $-
		or: [ (currentCharacter between: $0 and: $9)
				or: [ (currentCharacter between: $A and: $Z)
						or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ] ] ])
		ifTrue: [ ^ self scan22 ].
	^ self reportLastMatch
]

{ #category : #generated }
RDFTurtleScanner >> scan24 [
	[ self recordMatch: #(17).
	self step.
	currentCharacter == $.
		ifTrue: [ [ self step.
			currentCharacter == $. ] whileTrue.
			(currentCharacter == $-
				or: [ (currentCharacter between: $0 and: $9)
						or: [ (currentCharacter between: $A and: $Z)
								or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ] ] ])
				ifTrue: [ ^ self scan24 ].
			^ self reportLastMatch ].
	currentCharacter == $-
		or: [ (currentCharacter between: $0 and: $9)
				or: [ (currentCharacter between: $A and: $Z)
						or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ] ] ] ]
		whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
RDFTurtleScanner >> scan25 [
	self step.
	currentCharacter == $.
		ifTrue: [ ^ self scan23 ].
	currentCharacter == $:
		ifTrue: [ ^ self scan17 ].
	currentCharacter == $e
		ifTrue: [ self recordMatch: #(16).
			self step.
			currentCharacter == $.
				ifTrue: [ ^ self scan23 ].
			currentCharacter == $:
				ifTrue: [ ^ self scan17 ].
			(currentCharacter == $-
				or: [ (currentCharacter between: $0 and: $9)
						or: [ (currentCharacter between: $A and: $Z)
								or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ] ] ])
				ifTrue: [ ^ self scan22 ].
			^ self reportLastMatch ].
	(currentCharacter == $-
		or: [ (currentCharacter between: $0 and: $9)
				or: [ (currentCharacter between: $A and: $Z)
						or: [ currentCharacter == $_
								or: [ (currentCharacter between: $a and: $d)
										or: [ currentCharacter between: $f and: $z ] ] ] ] ])
		ifTrue: [ ^ self scan22 ].
	^ self reportLastMatch
]

{ #category : #generated }
RDFTurtleScanner >> scan3 [
	self step.
	(currentCharacter isDigit
		or: [ (currentCharacter between: $A and: $F)
				or: [ currentCharacter between: $a and: $f ] ])
		ifTrue: [ self step.
			(currentCharacter isDigit
				or: [ (currentCharacter between: $A and: $F)
						or: [ currentCharacter between: $a and: $f ] ])
				ifTrue: [ self step.
					(currentCharacter isDigit
						or: [ (currentCharacter between: $A and: $F)
								or: [ currentCharacter between: $a and: $f ] ])
						ifTrue: [ self step.
							(currentCharacter isDigit
								or: [ (currentCharacter between: $A and: $F)
										or: [ currentCharacter between: $a and: $f ] ])
								ifTrue: [ ^ self scan1 ] ] ] ].
	^ self reportLastMatch
]

{ #category : #generated }
RDFTurtleScanner >> scan4 [
	[ self step.
	currentCharacter == $"
		ifTrue: [ (self scanForString: '""')
				ifTrue: [ ^ self recordAndReportMatch: #(23) ].
			currentCharacter == $\
				ifTrue: [ ^ self scan5 ].
			^ self scan4 ].
	currentCharacter == $\
		ifTrue: [ ^ self scan5 ].
	true ] whileTrue
]

{ #category : #generated }
RDFTurtleScanner >> scan5 [
	self step.
	currentCharacter == $U
		ifTrue: [ self step.
			(currentCharacter isDigit
				or: [ (currentCharacter between: $A and: $F)
						or: [ currentCharacter between: $a and: $f ] ])
				ifTrue: [ self step.
					(currentCharacter isDigit
						or: [ (currentCharacter between: $A and: $F)
								or: [ currentCharacter between: $a and: $f ] ])
						ifTrue: [ self step.
							(currentCharacter isDigit
								or: [ (currentCharacter between: $A and: $F)
										or: [ currentCharacter between: $a and: $f ] ])
								ifTrue: [ self step.
									(currentCharacter isDigit
										or: [ (currentCharacter between: $A and: $F)
												or: [ currentCharacter between: $a and: $f ] ])
										ifTrue: [ ^ self scan6 ] ] ] ].
			^ self reportLastMatch ].
	currentCharacter == $u
		ifTrue: [ ^ self scan6 ].
	('"''\bfnrt' includes: currentCharacter)
		ifTrue: [ ^ self scan4 ].
	^ self reportLastMatch
]

{ #category : #generated }
RDFTurtleScanner >> scan6 [
	self step.
	(currentCharacter isDigit
		or: [ (currentCharacter between: $A and: $F)
				or: [ currentCharacter between: $a and: $f ] ])
		ifTrue: [ self step.
			(currentCharacter isDigit
				or: [ (currentCharacter between: $A and: $F)
						or: [ currentCharacter between: $a and: $f ] ])
				ifTrue: [ self step.
					(currentCharacter isDigit
						or: [ (currentCharacter between: $A and: $F)
								or: [ currentCharacter between: $a and: $f ] ])
						ifTrue: [ self step.
							(currentCharacter isDigit
								or: [ (currentCharacter between: $A and: $F)
										or: [ currentCharacter between: $a and: $f ] ])
								ifTrue: [ ^ self scan4 ] ] ] ].
	^ self reportLastMatch
]

{ #category : #generated }
RDFTurtleScanner >> scan7 [
	[ self step.
	currentCharacter == $'
		ifTrue: [ ^ self recordAndReportMatch: #(25) ].
	currentCharacter == $\
		ifTrue: [ ^ self scan8 ].
	currentCharacter <= Character tab
		or: [ (currentCharacter between: Character pageUp and: Character newPage)
				or: [ (currentCharacter between: (Character value: 14) and: $&)
						or: [ (currentCharacter between: $( and: $[)
								or: [ currentCharacter >= $] ] ] ] ] ] whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
RDFTurtleScanner >> scan8 [
	self step.
	currentCharacter == $U
		ifTrue: [ self step.
			(currentCharacter isDigit
				or: [ (currentCharacter between: $A and: $F)
						or: [ currentCharacter between: $a and: $f ] ])
				ifTrue: [ self step.
					(currentCharacter isDigit
						or: [ (currentCharacter between: $A and: $F)
								or: [ currentCharacter between: $a and: $f ] ])
						ifTrue: [ self step.
							(currentCharacter isDigit
								or: [ (currentCharacter between: $A and: $F)
										or: [ currentCharacter between: $a and: $f ] ])
								ifTrue: [ self step.
									(currentCharacter isDigit
										or: [ (currentCharacter between: $A and: $F)
												or: [ currentCharacter between: $a and: $f ] ])
										ifTrue: [ ^ self scan9 ] ] ] ].
			^ self reportLastMatch ].
	currentCharacter == $u
		ifTrue: [ ^ self scan9 ].
	('"''\bfnrt' includes: currentCharacter)
		ifTrue: [ ^ self scan7 ].
	^ self reportLastMatch
]

{ #category : #generated }
RDFTurtleScanner >> scan9 [
	self step.
	(currentCharacter isDigit
		or: [ (currentCharacter between: $A and: $F)
				or: [ currentCharacter between: $a and: $f ] ])
		ifTrue: [ self step.
			(currentCharacter isDigit
				or: [ (currentCharacter between: $A and: $F)
						or: [ currentCharacter between: $a and: $f ] ])
				ifTrue: [ self step.
					(currentCharacter isDigit
						or: [ (currentCharacter between: $A and: $F)
								or: [ currentCharacter between: $a and: $f ] ])
						ifTrue: [ self step.
							(currentCharacter isDigit
								or: [ (currentCharacter between: $A and: $F)
										or: [ currentCharacter between: $a and: $f ] ])
								ifTrue: [ ^ self scan7 ] ] ] ].
	^ self reportLastMatch
]

{ #category : #generated }
RDFTurtleScanner >> scanForToken [
	self step.
	currentCharacter == $"
		ifTrue:
			[ ^ self scanForTokenX7 ].
	currentCharacter == $'
		ifTrue:
			[ ^ self scanForTokenX6 ].
	currentCharacter == $(
		ifTrue: [ ^ self recordAndReportMatch: #(1) ].
	currentCharacter == $)
		ifTrue: [ ^ self recordAndReportMatch: #(2) ].
	currentCharacter == $,
		ifTrue: [ ^ self recordAndReportMatch: #(3) ].
	^ self scanForTokenX17
]

{ #category : #generated }
RDFTurtleScanner >> scanForTokenX1 [
	self step.
	currentCharacter == $.
		ifTrue: [ ^ self scan23 ].
	currentCharacter == $:
		ifTrue: [ ^ self scan17 ].
	currentCharacter == $R
		ifTrue:
			[ ^ self scanForTokenX1X1 ].
	(currentCharacter == $-
		or: [ (currentCharacter between: $0 and: $9)
				or: [ (currentCharacter between: $A and: $Q)
						or: [ (currentCharacter between: $S and: $Z)
								or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ] ] ] ])
		ifTrue: [ ^ self scan22 ].
	^ self reportLastMatch
]

{ #category : #generated }
RDFTurtleScanner >> scanForTokenX10 [
	self step.
	currentCharacter == $:
		ifTrue: [ self step.
			((currentCharacter between: $0 and: $9)
				or: [ (currentCharacter between: $A and: $Z)
						or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ] ])
				ifTrue: [ ^ self scan24 ] ].
	^ self reportLastMatch
]

{ #category : #generated }
RDFTurtleScanner >> scanForTokenX11 [
	self step.
	((currentCharacter between: $A and: $Z)
		or: [ currentCharacter between: $a and: $z ])
		ifTrue: [ [ self recordMatch: #(21).
			self step.
			currentCharacter == $-
				ifTrue: [ ^ self scan21 ].
			(currentCharacter between: $A and: $Z)
				or: [ currentCharacter between: $a and: $z ] ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
RDFTurtleScanner >> scanForTokenX12 [
	[ self recordMatch: #(14).
	self step.
	currentCharacter isSeparator
		or: [ currentCharacter == Character pageUp ] ] whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
RDFTurtleScanner >> scanForTokenX13 [
	self step.
	currentCharacter == $.
		ifTrue: [ self step.
			currentCharacter isDigit
				ifTrue: [ ^ self scan14 ].
			^ self reportLastMatch ].
	currentCharacter isDigit
		ifTrue: [ ^ self scan16 ].
	^ self reportLastMatch
]

{ #category : #generated }
RDFTurtleScanner >> scanForTokenX14 [
	self step.
	currentCharacter == $^
		ifTrue: [ ^ self recordAndReportMatch: #(12) ].
	^ self reportLastMatch
]

{ #category : #generated }
RDFTurtleScanner >> scanForTokenX15 [
	self recordMatch: #(4).
	self step.
	currentCharacter isDigit
		ifTrue: [ ^ self scan14 ].
	^ self reportLastMatch
]

{ #category : #generated }
RDFTurtleScanner >> scanForTokenX16 [
	currentCharacter == $f
		ifTrue:
			[ ^ self scanForTokenX3 ].
	currentCharacter == $t
		ifTrue:
			[ ^ self scanForTokenX4 ].
	currentCharacter isDigit
		ifTrue: [ ^ self scan16 ].
	('+-' includes: currentCharacter)
		ifTrue:
			[ ^ self scanForTokenX13 ].
	(currentCharacter isSeparator
		or: [ currentCharacter == Character pageUp ])
		ifTrue:
			[ ^ self scanForTokenX12 ].
	(currentCharacter == $A
		or: [ (currentCharacter between: $C and: $O)
				or: [ (currentCharacter between: $Q and: $Z)
						or: [ (currentCharacter between: $b and: $e)
								or: [ (currentCharacter between: $g and: $s)
										or: [ currentCharacter between: $u and: $z ] ] ] ] ])
		ifTrue: [ ^ self scan22 ].
	^ self reportLastMatch
]

{ #category : #generated }
RDFTurtleScanner >> scanForTokenX17 [
	currentCharacter == $.
		ifTrue:
			[ ^ self scanForTokenX15 ].
	currentCharacter == $:
		ifTrue: [ ^ self scan17 ].
	currentCharacter == $;
		ifTrue: [ ^ self recordAndReportMatch: #(5) ].
	currentCharacter == $<
		ifTrue:
			[ ^ self scanForTokenX5 ].
	currentCharacter == $@
		ifTrue:
			[ ^ self scanForTokenX11 ].
	currentCharacter == $B
		ifTrue:
			[ ^ self scanForTokenX2 ].
	currentCharacter == $P
		ifTrue:
			[ ^ self scanForTokenX1 ].
	currentCharacter == $[
		ifTrue:
			[ ^ self scanForTokenX9 ].
	currentCharacter == $]
		ifTrue: [ ^ self recordAndReportMatch: #(11) ].
	currentCharacter == $^
		ifTrue:
			[ ^ self scanForTokenX14 ].
	currentCharacter == $_
		ifTrue:
			[ ^ self scanForTokenX10 ].
	currentCharacter == $a
		ifTrue:
			[ ^ self scanForTokenX8 ].
	^ self scanForTokenX16
]

{ #category : #generated }
RDFTurtleScanner >> scanForTokenX1X1 [
	self step.
	currentCharacter == $.
		ifTrue: [ ^ self scan23 ].
	currentCharacter == $:
		ifTrue: [ ^ self scan17 ].
	currentCharacter == $E
		ifTrue:
			[ ^ self scanForTokenX1X1X1 ].
	(currentCharacter == $-
		or: [ (currentCharacter between: $0 and: $9)
				or: [ (currentCharacter between: $A and: $D)
						or: [ (currentCharacter between: $F and: $Z)
								or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ] ] ] ])
		ifTrue: [ ^ self scan22 ].
	^ self reportLastMatch
]

{ #category : #generated }
RDFTurtleScanner >> scanForTokenX1X1X1 [
	self step.
	currentCharacter == $.
		ifTrue: [ ^ self scan23 ].
	currentCharacter == $:
		ifTrue: [ ^ self scan17 ].
	currentCharacter == $F
		ifTrue: [ self step.
			currentCharacter == $.
				ifTrue: [ ^ self scan23 ].
			currentCharacter == $:
				ifTrue: [ ^ self scan17 ].
			currentCharacter == $I
				ifTrue: [ self step.
					currentCharacter == $.
						ifTrue: [ ^ self scan23 ].
					currentCharacter == $:
						ifTrue: [ ^ self scan17 ].
					currentCharacter == $X
						ifTrue: [ self recordMatch: #(9).
							self step.
							currentCharacter == $.
								ifTrue: [ ^ self scan23 ].
							currentCharacter == $:
								ifTrue: [ ^ self scan17 ].
							(currentCharacter == $-
								or: [ (currentCharacter between: $0 and: $9)
										or: [ (currentCharacter between: $A and: $Z)
												or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ] ] ])
								ifTrue: [ ^ self scan22 ].
							^ self reportLastMatch ].
					(currentCharacter == $-
						or: [ (currentCharacter between: $0 and: $9)
								or: [ (currentCharacter between: $A and: $W)
										or: [ (currentCharacter between: $Y and: $Z)
												or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ] ] ] ])
						ifTrue: [ ^ self scan22 ].
					^ self reportLastMatch ].
			(currentCharacter == $-
				or: [ (currentCharacter between: $0 and: $9)
						or: [ (currentCharacter between: $A and: $H)
								or: [ (currentCharacter between: $J and: $Z)
										or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ] ] ] ])
				ifTrue: [ ^ self scan22 ].
			^ self reportLastMatch ].
	(currentCharacter == $-
		or: [ (currentCharacter between: $0 and: $9)
				or: [ (currentCharacter between: $A and: $E)
						or: [ (currentCharacter between: $G and: $Z)
								or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ] ] ] ])
		ifTrue: [ ^ self scan22 ].
	^ self reportLastMatch
]

{ #category : #generated }
RDFTurtleScanner >> scanForTokenX2 [
	self step.
	currentCharacter == $.
		ifTrue: [ ^ self scan23 ].
	currentCharacter == $:
		ifTrue: [ ^ self scan17 ].
	currentCharacter == $A
		ifTrue: [ self step.
			currentCharacter == $.
				ifTrue: [ ^ self scan23 ].
			currentCharacter == $:
				ifTrue: [ ^ self scan17 ].
			currentCharacter == $S
				ifTrue: [ self step.
					currentCharacter == $.
						ifTrue: [ ^ self scan23 ].
					currentCharacter == $:
						ifTrue: [ ^ self scan17 ].
					currentCharacter == $E
						ifTrue: [ self recordMatch: #(8).
							self step.
							currentCharacter == $.
								ifTrue: [ ^ self scan23 ].
							currentCharacter == $:
								ifTrue: [ ^ self scan17 ].
							(currentCharacter == $-
								or: [ (currentCharacter between: $0 and: $9)
										or: [ (currentCharacter between: $A and: $Z)
												or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ] ] ])
								ifTrue: [ ^ self scan22 ].
							^ self reportLastMatch ].
					(currentCharacter == $-
						or: [ (currentCharacter between: $0 and: $9)
								or: [ (currentCharacter between: $A and: $D)
										or: [ (currentCharacter between: $F and: $Z)
												or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ] ] ] ])
						ifTrue: [ ^ self scan22 ].
					^ self reportLastMatch ].
			(currentCharacter == $-
				or: [ (currentCharacter between: $0 and: $9)
						or: [ (currentCharacter between: $A and: $R)
								or: [ (currentCharacter between: $T and: $Z)
										or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ] ] ] ])
				ifTrue: [ ^ self scan22 ].
			^ self reportLastMatch ].
	(currentCharacter == $-
		or: [ (currentCharacter between: $0 and: $9)
				or: [ (currentCharacter between: $B and: $Z)
						or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ] ] ])
		ifTrue: [ ^ self scan22 ].
	^ self reportLastMatch
]

{ #category : #generated }
RDFTurtleScanner >> scanForTokenX3 [
	self step.
	currentCharacter == $.
		ifTrue: [ ^ self scan23 ].
	currentCharacter == $:
		ifTrue: [ ^ self scan17 ].
	currentCharacter == $a
		ifTrue: [ self step.
			currentCharacter == $.
				ifTrue: [ ^ self scan23 ].
			currentCharacter == $:
				ifTrue: [ ^ self scan17 ].
			currentCharacter == $l
				ifTrue: [ self step.
					currentCharacter == $.
						ifTrue: [ ^ self scan23 ].
					currentCharacter == $:
						ifTrue: [ ^ self scan17 ].
					currentCharacter == $s
						ifTrue: [ ^ self scan25 ].
					(currentCharacter == $-
						or: [ (currentCharacter between: $0 and: $9)
								or: [ (currentCharacter between: $A and: $Z)
										or: [ currentCharacter == $_
												or: [ (currentCharacter between: $a and: $r)
														or: [ currentCharacter between: $t and: $z ] ] ] ] ])
						ifTrue: [ ^ self scan22 ].
					^ self reportLastMatch ].
			(currentCharacter == $-
				or: [ (currentCharacter between: $0 and: $9)
						or: [ (currentCharacter between: $A and: $Z)
								or: [ currentCharacter == $_
										or: [ (currentCharacter between: $a and: $k)
												or: [ currentCharacter between: $m and: $z ] ] ] ] ])
				ifTrue: [ ^ self scan22 ].
			^ self reportLastMatch ].
	(currentCharacter == $-
		or: [ (currentCharacter between: $0 and: $9)
				or: [ (currentCharacter between: $A and: $Z)
						or: [ currentCharacter == $_ or: [ currentCharacter between: $b and: $z ] ] ] ])
		ifTrue: [ ^ self scan22 ].
	^ self reportLastMatch
]

{ #category : #generated }
RDFTurtleScanner >> scanForTokenX4 [
	self step.
	currentCharacter == $.
		ifTrue: [ ^ self scan23 ].
	currentCharacter == $:
		ifTrue: [ ^ self scan17 ].
	currentCharacter == $r
		ifTrue: [ self step.
			currentCharacter == $.
				ifTrue: [ ^ self scan23 ].
			currentCharacter == $:
				ifTrue: [ ^ self scan17 ].
			currentCharacter == $u
				ifTrue: [ ^ self scan25 ].
			(currentCharacter == $-
				or: [ (currentCharacter between: $0 and: $9)
						or: [ (currentCharacter between: $A and: $Z)
								or: [ currentCharacter == $_
										or: [ (currentCharacter between: $a and: $t)
												or: [ currentCharacter between: $v and: $z ] ] ] ] ])
				ifTrue: [ ^ self scan22 ].
			^ self reportLastMatch ].
	(currentCharacter == $-
		or: [ (currentCharacter between: $0 and: $9)
				or: [ (currentCharacter between: $A and: $Z)
						or: [ currentCharacter == $_
								or: [ (currentCharacter between: $a and: $q)
										or: [ currentCharacter between: $s and: $z ] ] ] ] ])
		ifTrue: [ ^ self scan22 ].
	^ self reportLastMatch
]

{ #category : #generated }
RDFTurtleScanner >> scanForTokenX5 [
	[ self step.
	currentCharacter == $>
		ifTrue: [ ^ self recordAndReportMatch: #(18) ].
	currentCharacter == $#
		or: [ (currentCharacter between: $% and: $&)
				or: [ (currentCharacter between: $( and: $))
						or: [ (currentCharacter between: $, and: $:)
								or: [ currentCharacter == $=
										or: [ (currentCharacter between: $? and: $Z)
												or: [ ('\_' includes: currentCharacter)
														or: [ currentCharacter between: $a and: $z ] ] ] ] ] ] ] ]
		whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
RDFTurtleScanner >> scanForTokenX6 [
	self step.
	currentCharacter == $'
		ifTrue: [ self recordMatch: #(25).
			self step.
			currentCharacter == $'
				ifTrue: [ ^ self scan10 ].
			^ self reportLastMatch ].
	currentCharacter == $\
		ifTrue: [ ^ self scan8 ].
	(currentCharacter <= Character tab
		or: [ (currentCharacter between: Character pageUp and: Character newPage)
				or: [ (currentCharacter between: (Character value: 14) and: $&)
						or: [ (currentCharacter between: $( and: $[)
								or: [ currentCharacter >= $] ] ] ] ])
		ifTrue: [ ^ self scan7 ].
	^ self reportLastMatch
]

{ #category : #generated }
RDFTurtleScanner >> scanForTokenX7 [
	self step.
	currentCharacter == $"
		ifTrue: [ self recordMatch: #(24).
			self step.
			currentCharacter == $"
				ifTrue: [ ^ self scan4 ].
			^ self reportLastMatch ].
	currentCharacter == $\
		ifTrue: [ ^ self scan2 ].
	(currentCharacter <= Character tab
		or: [ (currentCharacter between: Character pageUp and: Character newPage)
				or: [ (currentCharacter between: (Character value: 14) and: $!)
						or: [ (currentCharacter between: $# and: $[)
								or: [ currentCharacter >= $] ] ] ] ])
		ifTrue: [ ^ self scan1 ].
	^ self reportLastMatch
]

{ #category : #generated }
RDFTurtleScanner >> scanForTokenX8 [
	self recordMatch: #(13).
	self step.
	currentCharacter == $.
		ifTrue: [ ^ self scan23 ].
	currentCharacter == $:
		ifTrue: [ ^ self scan17 ].
	(currentCharacter == $-
		or: [ (currentCharacter between: $0 and: $9)
				or: [ (currentCharacter between: $A and: $Z)
						or: [ currentCharacter == $_ or: [ currentCharacter between: $a and: $z ] ] ] ])
		ifTrue: [ ^ self scan22 ].
	^ self reportLastMatch
]

{ #category : #generated }
RDFTurtleScanner >> scanForTokenX9 [
	self recordMatch: #(10).
	self step.
	currentCharacter == $]
		ifTrue: [ ^ self recordAndReportMatch: #(17) ].
	((currentCharacter between: Character tab and: Character lf)
		or: [ currentCharacter == Character cr
				or: [ currentCharacter == Character space ] ])
		ifTrue: [ [ self step.
			currentCharacter == $]
				ifTrue: [ ^ self recordAndReportMatch: #(17) ].
			(currentCharacter between: Character tab and: Character lf)
				or: [ currentCharacter == Character cr
						or: [ currentCharacter == Character space ] ] ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
RDFTurtleScanner >> tokenActions [
	^ #(nil nil nil nil nil nil nil nil nil nil nil nil nil #whitespace)
]
