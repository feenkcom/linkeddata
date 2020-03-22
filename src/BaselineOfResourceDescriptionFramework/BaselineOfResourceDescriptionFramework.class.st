Class {
	#name : #BaselineOfResourceDescriptionFramework,
	#superclass : #BaselineOf,
	#category : #BaselineOfResourceDescriptionFramework
}

{ #category : #baseline }
BaselineOfResourceDescriptionFramework >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec baseline: 'ResourceDescriptionFrameworkCore' with: [
				spec repository: 'github://feenkcom/linkeddata:v0.6.0/src' ].
		spec package: 'ResourceDescriptionFramework-Examples' with: [
				spec requires: #('ResourceDescriptionFrameworkCore' ). ]. ].

]
