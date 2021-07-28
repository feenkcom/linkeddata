Class {
	#name : #POLYFactory,
	#superclass : #RDFTermFactory,
	#category : 'ResourceDescriptionFramework-Core-Factories'
}

{ #category : #accessing }
POLYFactory >> baseDomain [
	^ self namedNodeSuffix: 'baseDomain'
]

{ #category : #accessing }
POLYFactory >> endIndex [
	^ self namedNodeSuffix: 'endIndex'
]

{ #category : #accessing }
POLYFactory >> entity [
	^ self namedNodeSuffix: 'Entity'
]

{ #category : #accessing }
POLYFactory >> favouriteCount [
	^ self namedNodeSuffix: 'favouriteCount'
]

{ #category : #accessing }
POLYFactory >> fileName [
	^ self namedNodeSuffix: 'fileName'
]

{ #category : #accessing }
POLYFactory >> follows [
	^ self namedNodeSuffix: 'follows'
]

{ #category : #accessing }
POLYFactory >> hasUserMention [
	^ self namedNodeSuffix: 'hasUserMention'
]

{ #category : #accessing }
POLYFactory >> inReplyTo [
	^ self namedNodeSuffix: 'inReplyTo'
]

{ #category : #accessing }
POLYFactory >> isFavourited [
	^ self namedNodeSuffix: 'isFavourited'
]

{ #category : #accessing }
POLYFactory >> isFollowedBy [
	^ self namedNodeSuffix: 'isFollowedBy'
]

{ #category : #accessing }
POLYFactory >> isRetweet [
	^ self namedNodeSuffix: 'isRetweet'
]

{ #category : #accessing }
POLYFactory >> possibleSensitive [
	^ self namedNodeSuffix: 'possibleSensitive'
]

{ #category : #factory }
POLYFactory >> prefix [
	^ 'http://polypoly.eu/schema/'
]

{ #category : #accessing }
POLYFactory >> referencer [
	^ self namedNodeSuffix: 'referencer'
]

{ #category : #accessing }
POLYFactory >> reply [
	^ self namedNodeSuffix: 'reply'
]

{ #category : #accessing }
POLYFactory >> retweetCount [
	^ self namedNodeSuffix: 'retweetCount'
]

{ #category : #factory }
POLYFactory >> shortName [
	^ 'poly'
]

{ #category : #accessing }
POLYFactory >> sphere [
	^ self namedNodeSuffix: 'sphere'
]

{ #category : #accessing }
POLYFactory >> startIndex [
	^ self namedNodeSuffix: 'startIndex'
]

{ #category : #accessing }
POLYFactory >> userMention [
	^ self namedNodeSuffix: 'UserMention'
]
