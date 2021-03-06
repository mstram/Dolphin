"Filed out from Dolphin Smalltalk 7"!

KeyedAspect subclass: #InstVarAspect
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
InstVarAspect guid: (GUID fromString: '{c92cbde8-f3b1-4799-9a70-0f2b15a024fc}')!
InstVarAspect comment: ''!
!InstVarAspect categoriesForClass!Development! !
!InstVarAspect methodsFor!

batchSize
	"Answers the batch size of the receiver, i.e. the number of keyed elements to return at a time"

	^200!

canWriteInto: anObject
	^self key ~= 0 and: [super canWriteInto: anObject]!

displayAspectNameOf: anObject on: aStream 
	self key == 0 
		ifTrue: [aStream nextPutAll: 'self']
		ifFalse: [aStream display: (self instVarName: anObject)]!

displayAspectText: anObject on: aStream 
	self key == 0 
		ifFalse: 
			[aStream
				display: (self instVarName: anObject);
				nextPut: $=].
	(self readFrom: anObject) aspectDisplayOn: aStream!

instVarName: anObject
	"Answer the name of the instance variable described by the receiver in the 
	specified <Object>."

	| fixedSize index |
	(index := self key) = 0 ifTrue: [^#self].
	fixedSize := anObject class instSize.
	^index <= fixedSize ifTrue: [anObject class allInstVarNames at: index] ifFalse: [index - fixedSize]!

nameIn: anObject
	"Private - Answer the 'name' of the aspect of the <Object> argument described by the receiver."

	^self instVarName: anObject!

objectRefName: anObject
	| index stream |
	index := self key.
	stream := String writeStream.
	index > anObject class instSize 
		ifTrue: [stream nextPutAll: (anObject basicPrintString copyWithout: Character space)].
	stream display: (self instVarName: anObject).
	^stream contents!

readFrom: anObject
	^self key = 0 ifTrue: [anObject] ifFalse: [anObject instVarAt: self key]!

selectIn: anInspector
	anInspector selectAspect: self!

writeInto: subjectObject value: valueObject
	"Private - Set the attribute of subjectObject described by the receiver 
	to valueObject."

	^subjectObject instVarAt: self key put: valueObject! !
!InstVarAspect categoriesFor: #batchSize!constants!public! !
!InstVarAspect categoriesFor: #canWriteInto:!private!testing! !
!InstVarAspect categoriesFor: #displayAspectNameOf:on:!displaying!private! !
!InstVarAspect categoriesFor: #displayAspectText:on:!displaying!private! !
!InstVarAspect categoriesFor: #instVarName:!accessing!public! !
!InstVarAspect categoriesFor: #nameIn:!accessing!private! !
!InstVarAspect categoriesFor: #objectRefName:!helpers!private! !
!InstVarAspect categoriesFor: #readFrom:!indirect accessing!private! !
!InstVarAspect categoriesFor: #selectIn:!event handling!private! !
!InstVarAspect categoriesFor: #writeInto:value:!indirect accessing!private! !

