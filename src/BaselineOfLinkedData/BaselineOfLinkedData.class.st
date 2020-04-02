Class {
	#name : #BaselineOfLinkedData,
	#superclass : #BaselineOf,
	#category : #BaselineOfLinkedData
}

{ #category : #baseline }
BaselineOfLinkedData >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec baseline: 'ResourceDescriptionFramework' with: [
				spec repository: 'github://feenkcom/linkeddata:v0.6.1/src' ]. ].

]
