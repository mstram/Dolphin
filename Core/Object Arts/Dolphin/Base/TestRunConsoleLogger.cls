"Filed out from Dolphin Smalltalk 7"!

TestRunLogger subclass: #TestRunConsoleLogger
	instanceVariableNames: 'stream timings'
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
TestRunConsoleLogger guid: (GUID fromString: '{c279d11f-90f1-4fe3-bfa6-09a2d85a208e}')!
TestRunConsoleLogger comment: ''!
!TestRunConsoleLogger categoriesForClass!Kernel-Objects! !
!TestRunConsoleLogger methodsFor!

finishedCase: aTestCaseResult
	stream
		nextPutAll: aTestCaseResult outcome asUppercase;
		nextPutAll: ' in '.
	self printRuntime: aTestCaseResult duration.
	stream cr!

finishedRun: aTestResult knownSlowTests: aCollection
	| passed |
	passed := aTestResult hasPassed.
	stream
		nextPutAll: (passed ifTrue: ['PASSED'] ifFalse: ['FAILED']);
		cr;
		nextPutAll: aTestResult printString;
		nextPutAll: ' in '.
	self printRuntime: aTestResult duration.
	stream cr.
	passed
		ifTrue: 
			[self
				summarizeTimings: aTestResult
				baseline: aCollection
				threshold: self slowTestThreshold * 1000]
		ifFalse: [self summarizeFailures: aTestResult].
	stream flush!

printRuntime: microsecondsInteger
	| mS |
	mS := microsecondsInteger / 1000.0.
	mS < 1000.0
		ifTrue: 
			[mS printOn: stream decimalPlaces: (mS < 1.0 ifTrue: [3] ifFalse: [0]).
			stream nextPutAll: ' mS']
		ifFalse: 
			[| secs |
			secs := mS / 1000.0.
			secs printOn: stream decimalPlaces: (secs < 10.0 ifTrue: [1] ifFalse: [0]).
			stream nextPutAll: ' s']!

startingCase: aTestCase
	stream
		print: aTestCase;
		nextPutAll: ' ... ';
		flush!

stream: anObject
	stream := anObject!

summarizeFailures: aTestResult
	| failures errors |
	failures := aTestResult failures.
	failures notEmpty
		ifTrue: 
			[stream
				cr;
				nextPutAll: 'FAILURES:';
				cr.
			failures do: 
					[:each |
					stream
						print: each;
						cr]].
	errors := aTestResult errors.
	errors notEmpty
		ifTrue: 
			[stream
				cr;
				nextPutAll: 'ERRORS:';
				cr.
			errors do: 
					[:each |
					stream
						print: each;
						cr]]!

summarizeTimings: aTestResult baseline: aCollection threshold: anInteger
	| laggards newLaggards |
	laggards := (aTestResult results select: [:each | each duration >= anInteger])
				asSortedCollectionUsing: (MergesortAlgorithm sortBlock: [:a :b | a duration > b duration]).
	newLaggards := laggards reject: [:each | aCollection includes: each case].
	newLaggards size > 0 ifFalse: [^self].
	stream
		print: newLaggards size;
		nextPutAll: ' test(s) took '.
	self printRuntime: anInteger.
	stream
		nextPutAll: ' or more to run, not including ';
		print: aCollection size;
		nextPutAll: ' known laggards:';
		cr.
	newLaggards do: 
			[:each |
			stream tab.
			self printRuntime: each duration.
			stream
				tab;
				print: each case;
				cr]! !
!TestRunConsoleLogger categoriesFor: #finishedCase:!logging!public! !
!TestRunConsoleLogger categoriesFor: #finishedRun:knownSlowTests:!logging!public! !
!TestRunConsoleLogger categoriesFor: #printRuntime:!helpers!private! !
!TestRunConsoleLogger categoriesFor: #startingCase:!logging!public! !
!TestRunConsoleLogger categoriesFor: #stream:!accessing!private! !
!TestRunConsoleLogger categoriesFor: #summarizeFailures:!helpers!private! !
!TestRunConsoleLogger categoriesFor: #summarizeTimings:baseline:threshold:!helpers!private! !

!TestRunConsoleLogger class methodsFor!

on: aPuttableStream
	^(self new)
		stream: aPuttableStream;
		yourself! !
!TestRunConsoleLogger class categoriesFor: #on:!public! !

