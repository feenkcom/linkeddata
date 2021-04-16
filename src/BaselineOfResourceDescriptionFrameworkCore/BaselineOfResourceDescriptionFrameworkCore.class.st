Class {
	#name : #BaselineOfResourceDescriptionFrameworkCore,
	#superclass : #BaselineOf,
	#category : #BaselineOfResourceDescriptionFrameworkCore
}

{ #category : #baseline }
BaselineOfResourceDescriptionFrameworkCore >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec 
			package: 'ResourceDescriptionFramework-Core';
			package: 'Sparql-Client'.
	]
]
