"Filed out from Dolphin Smalltalk 7"!

DolphinTest subclass: #SmalltalkParserTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: 'ExtCallArgTypes SmalltalkParseErrorCodes'
	classInstanceVariableNames: ''!
SmalltalkParserTest guid: (GUID fromString: '{947b6d13-1a2a-43c0-8053-bde0fccfbd44}')!
SmalltalkParserTest comment: 'SUnitBrowser openOnTestCase: self'!
!SmalltalkParserTest categoriesForClass!Refactory-Testing! !
!SmalltalkParserTest methodsFor!

assertToken: aStToken isChar: aCharacter
	self assert: aStToken isLiteralToken.
	self assert: aStToken value == aCharacter!

parserClass
	^SmalltalkParser!

scannerClass
	^SmalltalkScanner!

testCharacterScanning
	| subject tok |
	subject := self scannerClass on: '$a$b$\t$\$  $c' readStream.
	tok := subject next.
	self assertToken: tok isChar: $a.
	self assert: tok sourceInterval equals: (1 to: 2).
	tok := subject next.
	self assertToken: tok isChar: $b.
	self assert: tok sourceInterval equals: (3 to: 4).
	tok := subject next.
	self assertToken: tok isChar: Character tab.
	self assert: tok sourceInterval equals: (5 to: 7).
	tok := subject next.
	self assertToken: tok isChar: $\.
	self assert: tok sourceInterval equals: (8 to: 9).
	tok := subject next.
	self assertToken: tok isChar: Character space.
	self assert: tok sourceInterval equals: (10 to: 11).
	tok := subject next.
	self assertToken: tok isChar: $c.
	self assert: tok sourceInterval equals: (13 to: 14).
	0 to: 255
		do: 
			[:i |
			| char ch source interval |
			ch := Character value: i.
			subject := self scannerClass on: ch printString readStream.
			char := subject next.
			self assertToken: char isChar: ch.
			self assert: subject next isEof.
			source := ' $\x<1s> ' expandMacrosWith: i asHexString.
			subject := self scannerClass on: source readStream.
			char := subject next.
			self assertToken: char isChar: ch.
			interval := char sourceInterval.
			self assert: interval equals: (2 to: source size - 1).
			self assert: subject next isEof].
	subject := self scannerClass on: ' $\. ' readStream.
	tok := subject next.
	self assertToken: tok isChar: (Character value: 92).
	self assert: tok sourceInterval equals: (2 to: 3).
	self assert: (subject next isSpecial: $.).
	subject := self scannerClass on: '$\c' readStream.
	tok := subject next.
	self assertToken: tok isChar: (Character value: 92).
	self assert: tok sourceInterval equals: (1 to: 2).
	tok := subject next.
	self assert: tok isIdentifier.
	self assert: tok value equals: 'c'.
	subject := self scannerClass on: '$\xAG' readStream.
	tok := subject next.
	self assertToken: tok isChar: (Character value: 16rA).
	self assert: tok sourceInterval equals: (1 to: 4).
	tok := subject next.
	self assert: tok isIdentifier.
	self assert: tok value equals: 'G'!

testExpressionSolver
	#(#('y := 3' nil) #('x := 3' 'x := 3') #('y := x' 'x := y') #('y := x + 1' 'x := y - 1') #('y := x >> 2 - 1' 'x := y + 1 << 2') #('y := 1+z/x' 'x := (1 + z) / y') #('y := a - ((b / x) * c)' 'x := b / ((a - y) / c)') #('y := (m*x)+b' 'x := (y - b) / m') #('y := (m/x)-b' 'x := m / (y + b)' #('y:=a-c*x/(d-e)-f')))
		do: 
			[:pair |
			| expr solution case |
			case := pair first.
			expr := self parserClass parseExpression: case.
			(case includes: 'y')
				ifTrue: 
					[solution := expr solveFor: 'y'.
					self assert: solution == expr].
			solution := expr solveFor: 'x'.
			pair second
				ifNil: [self assert: solution isNil]
				ifNotNil: [:expected | self assert: solution formattedCode equals: expected]]!

testExternalCallEquality
	| strings |
	strings := #('test <stdcall: void Test>' 'test <overlap stdcall: void Test>' 'test: a <stdcall: void Test dword>').
	1 to: strings size
		do: 
			[:i | 
			1 to: strings size
				do: 
					[:j | 
					self 
						deny: ((self parserClass parseMethod: (strings at: i)) 
								= (self parserClass parseMethod: (strings at: j)) xor: i = j)]]!

testExternalCalls
	| ffiCall tree src types |
	self assert: (KernelLibrary parseTreeFor: #loadLibraryEx:hFile:dwFlags:) isPrimitive.
	"Zero args"
	tree := SmalltalkParser parseMethod: 'blah <stdcall: void blah>'.
	self assert: tree formattedCode trimBlanks = 'blah
	<stdcall: void blah>'.
	ffiCall := tree tag.
	self assert: ffiCall argumentTypes isEmpty.
	self assert: ffiCall returnType typeOrdinal = ExtCallArgVOID.
	self assert: ffiCall returnType indirections = 0.
	self assert: ffiCall returnType structClass isNil.

	"One simple arg"
	tree := SmalltalkParser parseMethod: 'blah: x <stdcall: dword blah sdword>'.
	self assert: tree formattedCode trimBlanks = 'blah: x
	<stdcall: dword blah sdword>'.
	ffiCall := tree tag.
	self assert: ffiCall returnType typeOrdinal = ExtCallArgDWORD.
	self assert: ffiCall returnType indirections = 0.
	self assert: ffiCall returnType structClass isNil.
	self assert: ffiCall argumentTypes size = 1.
	ffiCall argumentTypes with: (Array with: ExtCallArgSDWORD)
		do: 
			[:eachArg :eachType |
			self assert: eachArg typeOrdinal = eachType.
			self assert: eachArg indirections = 0.
			self assert: eachArg structClass isNil].

	"Void is not a valid argument type (can only be used for return)"
	self
		should: [SmalltalkParser parseMethod: 'blah: x <stdcall: void blah void>']
		raise: SmalltalkParser errorClass
		matching: [:err | err errorCode = CErrArgTypeCannotBeVoid].

	"Mismatch between Smalltalk arguments and external argument types."
	self should: [SmalltalkParser parseMethod: 'blah: x _: y <stdcall: void blah void>']
		raise: SmalltalkParser errorClass.


	"Many simple args"
	src := String writeStream.
	types := #('lpvoid' 'char' 'byte' 'sbyte' 'word' 'sword' 'dword' 'sdword' 'bool' 'handle' 'double' 'lpstr' 'oop' 'float' 'lppvoid' 'hresult' 'lpwstr' 'qword' 'sqword' 'ote' 'bstr' 'variant' 'date' 'varbool' 'guid').
	types do: 
			[:each |
			src
				nextPutAll: each;
				nextPutAll: ': ';
				nextPutAll: each]
		separatedBy: [src space].
	src
		crtab;
		nextPutAll: '<stdcall: void fn'.
	types do: 
			[:each |
			src
				space;
				nextPutAll: each].
	src nextPut: $>.
	src := src contents.
	tree := SmalltalkParser parseMethod: src.
	self assert: tree formattedCode trimBlanks = src.
	ffiCall := tree tag.
	self assert: ffiCall argumentTypes size = types size.
	ffiCall argumentTypes with: (1 to: types size)
		do: 
			[:eachArg :eachType |
			self assert: eachArg typeOrdinal = eachType.
			self assert: eachArg indirections = 0.
			self assert: eachArg structClass isNil]! !
!SmalltalkParserTest categoriesFor: #assertToken:isChar:!helpers!private! !
!SmalltalkParserTest categoriesFor: #parserClass!constants!private! !
!SmalltalkParserTest categoriesFor: #scannerClass!constants!private! !
!SmalltalkParserTest categoriesFor: #testCharacterScanning!public!unit tests! !
!SmalltalkParserTest categoriesFor: #testExpressionSolver!public! !
!SmalltalkParserTest categoriesFor: #testExternalCallEquality!public!unit tests! !
!SmalltalkParserTest categoriesFor: #testExternalCalls!public!unit tests! !

!SmalltalkParserTest class methodsFor!

parserClass
	^SmalltalkParser! !
!SmalltalkParserTest class categoriesFor: #parserClass!accessing!public! !

