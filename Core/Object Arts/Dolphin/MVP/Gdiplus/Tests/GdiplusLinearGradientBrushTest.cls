"Filed out from Dolphin Smalltalk 7"!

GdiplusTests subclass: #GdiplusLinearGradientBrushTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
GdiplusLinearGradientBrushTest guid: (GUID fromString: '{da79074f-df9f-4e17-85cb-3cbe8999807f}')!
GdiplusLinearGradientBrushTest comment: ''!
!GdiplusLinearGradientBrushTest categoriesForClass!Unclassified! !
!GdiplusLinearGradientBrushTest methodsFor!

setSample1
	model := GdiplusLinearGradientBrush 
				point1: 0 @ 0
				point2: 255 @ 0
				color1: ARGB red
				color2: ARGB blue!

testClone
	"force realize"

	| clone |
	self setSample1.
	model handle.
	clone := model clone.
	self assert: model initializer == clone initializer.
	self assert: clone basicHandle notNil!

testConstructor1
	self setSample1.
	model asParameter.
	self assertPersistedValid!

testConstructor2
	model := GdiplusLinearGradientBrush 
				rect: (0 @ 0 extent: 255 @ 255)
				color1: (ARGB fromInteger: 4294901760)
				color2: (ARGB fromInteger: 4278190335)
				mode: 0.
	model asParameter.
	self assertPersistedValid!

testFillingHorizontal
	| bitmap graphics canvas |
	bitmap := DIBSection displayCompatibleWithExtent: 256 @ 256.
	canvas := bitmap canvas.
	graphics := GdiplusGraphics fromCanvas: canvas.
	self setSample1.
	graphics fillRectangle: (0 @ 0 extent: 256 @ 256) brush: model.
	graphics free.
	self assert: (canvas pixelAt: 0 @ 0) = RGB red.
	self assert: (canvas pixelAt: 128 @ 0) = RGB darkMagenta.
	self assert: (canvas pixelAt: 255 @ 0) = RGB blue!

testGetBlend
	| args answer |
	self setSample1.
	args := Array with: #(0.0 0.5 1.0) with: #(0.0 0.8 1.0).
	"Test the roundtrip; setting then getting"
	model blendFactors: args first positions: args second.
	answer := model blendFactors.
	args first with: answer first do: [:f1 :f2 | self assert: (self compare: f1 to: f2)].
	"SW: How many bits of precision does REAL have?
	BSM: Its probably only single precision, so only about 6 or 7 digits
	LAS: In which case why isn't DignificantDifference in Float = 0.000001 so that Float>>equals: will work or 
	suggestion: a Float>>equals:epsilon: method (in the base image)?"
	args second with: answer second do: [:f1 :f2 | self assert: (self compare: f1 to: f2)]!

testGetBlendCount
	self setSample1.
	"MSDN: If no custom blend has been set by using LinearGradientBrush::SetBlend, or if invalid positions were passed to LinearGradientBrush::SetBlend, then LinearGradientBrush::GetBlend returns 1."
	self assert: model blendCount = 1.
	model blendFactors: #(0.0 0.5 1.0) positions: #(0.0 0.8 1.0).
	self assert: model blendCount = 3!

testIsGammaCorrected
	self setSample1.
	model isGammaCorrected: true.
	self assert: model isGammaCorrected.
	model isGammaCorrected: false.
	self deny: model isGammaCorrected!

testPersistentArgument
	"Create an object that has a constructor argument that itself needs to be realised"

	| brush pen |
	brush := GdiplusLinearGradientBrush 
				point1: 0 @ 0
				point2: 255 @ 0
				color1: ARGB red
				color2: ARGB blue.
	pen := GdiplusPen brush: brush width: nil.
	"realize it"
	pen asParameter.
	self assert: brush isRealized.
	"re-realize it"
	pen free.
	pen asParameter.
	"re-realize all"
	pen free.
	brush free.
	pen asParameter.
	self assert: brush isRealized.
	self assert: pen initializer brush == brush
	"for gc reasons .. the pen must always hold a reference to the brush"! !
!GdiplusLinearGradientBrushTest categoriesFor: #setSample1!accessing!public! !
!GdiplusLinearGradientBrushTest categoriesFor: #testClone!public!unit tests! !
!GdiplusLinearGradientBrushTest categoriesFor: #testConstructor1!public!unit tests! !
!GdiplusLinearGradientBrushTest categoriesFor: #testConstructor2!public!unit tests! !
!GdiplusLinearGradientBrushTest categoriesFor: #testFillingHorizontal!public!unit tests! !
!GdiplusLinearGradientBrushTest categoriesFor: #testGetBlend!public!unit tests! !
!GdiplusLinearGradientBrushTest categoriesFor: #testGetBlendCount!public!unit tests! !
!GdiplusLinearGradientBrushTest categoriesFor: #testIsGammaCorrected!public!unit tests! !
!GdiplusLinearGradientBrushTest categoriesFor: #testPersistentArgument!public!unit tests! !

