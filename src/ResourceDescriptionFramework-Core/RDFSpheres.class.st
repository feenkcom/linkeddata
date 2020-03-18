Class {
	#name : #RDFSpheres,
	#superclass : #RDFTriples,
	#category : #'ResourceDescriptionFramework-Core-Collections'
}

{ #category : #initialization }
RDFSpheres >> defaultCollection [
	<return: #Collection>
	^ OrderedCollection new
]

{ #category : #'gt-extension' }
RDFSpheres >> gtSpheresFor: aView [
	<gtView>
	self collection ifNil: [ ^ aView empty ].
	^ aView list
		title: 'Spheres';
		priority: 1;
		items: [ self collection ];
		itemFormat: [ :aTriple | aTriple sentence ];
		send: [ :aTriple | 
			self resourceWithSphereFor: aTriple ]
]

{ #category : #enumerating }
RDFSpheres >> resourceWithSphereFor: aTriple [
	<return: #RDFResourceWithSphere>
	| aSphere aSubject |
	aSphere := RDFSphere ofName: aTriple object term value.
	aSubject := aTriple subject.
	^ self store resourceForSubject: aSubject withSphere: aSphere.
]
