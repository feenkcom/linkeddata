Class {
	#name : #POLY,
	#superclass : #RDFConvenience,
	#category : #'ResourceDescriptionFramework-Core-Factories'
}

{ #category : #factory }
POLY class >> baseDomain [
	^ self factory baseDomain
]

{ #category : #factory }
POLY class >> endIndex [
	^ self factory endIndex
]

{ #category : #accessing }
POLY class >> factory [
	^ POLYFactory default
]

{ #category : #factory }
POLY class >> favouriteCount [
	^ self factory favouriteCount
]

{ #category : #factory }
POLY class >> fileName [
	^ self factory fileName
]

{ #category : #factory }
POLY class >> follows [
	^ self factory follows
]

{ #category : #factory }
POLY class >> hasUserMention [
	^ self factory hasUserMention
]

{ #category : #factory }
POLY class >> inReplyTo [
	^ self factory inReplyTo
]

{ #category : #'as yet unclassified' }
POLY class >> iriNames [

	^#(baseDomain endIndex favouriteCount fileName follows hasUserMention inReplyTo isFavourited isFollowedBy isRetweet possibleSensitive referencer reply retweetCount sphere startIndex userMention)
]

{ #category : #factory }
POLY class >> isFavourited [
	^ self factory isFavourited
]

{ #category : #factory }
POLY class >> isFollowedBy [
	^ self factory isFollowedBy
]

{ #category : #factory }
POLY class >> isRetweet [
	^ self factory isRetweet
]

{ #category : #factory }
POLY class >> possibleSensitive [
	^ self factory possibleSensitive
]

{ #category : #factory }
POLY class >> referencer [
	^ self factory referencer
]

{ #category : #factory }
POLY class >> reply [
	^ self factory reply
]

{ #category : #factory }
POLY class >> retweetCount [
	^ self factory retweetCount
]

{ #category : #factory }
POLY class >> sphere [
	^ self factory sphere
]

{ #category : #factory }
POLY class >> startIndex [
	^ self factory startIndex
]

{ #category : #factory }
POLY class >> userMention [
	^ self factory userMention
]
