"Filed out from Dolphin Smalltalk 7"!

IUnknown subclass: #ADODBADOConnectionConstruction15
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: 'ADODBConstants'
	classInstanceVariableNames: ''!
ADODBADOConnectionConstruction15 guid: (IID fromString: '{00000516-0000-0010-8000-00AA006D2EA4}')!
ADODBADOConnectionConstruction15 comment: '<ADODBADOConnectionConstruction15> is a wrapper class for the COM interface ''ADODB.ADOConnectionConstruction15'' generated from type information in the ''Microsoft ActiveX Data Objects 2.5 Library'' library. It contains methods to invoke the member functions exposed by that interface.

The type library contains no documentation for this interface

Warning: This comment was automatically generated from the interface''s type information, but any changes made here will not be overwritten if the wrapper class is regenerated.'!
!ADODBADOConnectionConstruction15 categoriesForClass!ADODB-Interfaces!COM-Interfaces! !
!ADODBADOConnectionConstruction15 methodsFor!

dso
	"Answer the <IUnknown> value of the 'DSO' property of the receiver."

	| answer |
	answer := IUnknown newPointer.
	self get_DSO: answer.
	^answer asObject
!

get_DSO: ppDSO
	"Private - Get the value of the 'DSO' property of the receiver.
				HRESULT __stdcall DSO(
			[out, retval] IUnknown** ppDSO);"

	<virtual stdcall: hresult 4 IUnknown**>
	^self invalidCall
!

get_Session: ppSession
	"Private - Get the value of the 'Session' property of the receiver.
				HRESULT __stdcall Session(
			[out, retval] IUnknown** ppSession);"

	<virtual stdcall: hresult 5 IUnknown**>
	^self invalidCall
!

session
	"Answer the <IUnknown> value of the 'Session' property of the receiver."

	| answer |
	answer := IUnknown newPointer.
	self get_Session: answer.
	^answer asObject
!

WrapDSOandSession: pDSO pSession: pSession
	"Invoke the WrapDSOandSession() method of the COM object.

		HRESULT __stdcall WrapDSOandSession(
			[in] IUnknown* pDSO,
			[in] IUnknown* pSession);"

	<virtual stdcall: hresult 6 IUnknown* IUnknown*>
	^self invalidCall
! !
!ADODBADOConnectionConstruction15 categoriesFor: #dso!**auto generated**!properties!public! !
!ADODBADOConnectionConstruction15 categoriesFor: #get_DSO:!**auto generated**!COM Interfaces-ADOConnectionConstruction15!private! !
!ADODBADOConnectionConstruction15 categoriesFor: #get_Session:!**auto generated**!COM Interfaces-ADOConnectionConstruction15!private! !
!ADODBADOConnectionConstruction15 categoriesFor: #session!**auto generated**!properties!public! !
!ADODBADOConnectionConstruction15 categoriesFor: #WrapDSOandSession:pSession:!**auto generated**!COM Interfaces-ADOConnectionConstruction15!public! !

!ADODBADOConnectionConstruction15 class methodsFor!

defineFunctions
	"Declare the virtual function table for the COM interface 'ADODB.ADOConnectionConstruction15'
		ADODBADOConnectionConstruction15 defineTemplate"

	self
		defineFunction: #get_DSO:
			argumentTypes: 'IUnknown**';
		defineFunction: #get_Session:
			argumentTypes: 'IUnknown**';
		defineFunction: #WrapDSOandSession:pSession:
			argumentTypes: 'IUnknown* IUnknown*'
! !
!ADODBADOConnectionConstruction15 class categoriesFor: #defineFunctions!**auto generated**!initializing!public! !

