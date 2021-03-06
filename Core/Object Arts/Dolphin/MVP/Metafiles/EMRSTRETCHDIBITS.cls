"Filed out from Dolphin Smalltalk 7"!

ENHMETARECORD subclass: #EMRSTRETCHDIBITS
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
EMRSTRETCHDIBITS guid: (GUID fromString: '{bfcc8077-e3d1-4f40-81c8-b36128972f7a}')!
EMRSTRETCHDIBITS comment: '<EMRSTRETCHDIBITS> is an <ExternalStructure> class to wrap the struct ''Win32.EMRSTRETCHDIBITS'' from type information in the ''Win32 API (ANSI). Derived from Bruce McKinney�s Hardcore Visual Basic Type Library'' library.

The type library contains no documentation for this struct

Warning: This comment was automatically generated from the struct''s type information, but any changes made here will not be overwritten if the wrapper class is regenerated.

IDL definition follows:

typedef [uuid(BFCC8077-E3D1-4F40-81C8-B36128972F7A)]
struct tagEMRSTRETCHDIBITS {
	EMR EMR;
	[helpstring("Inclusive-inclusive bounds in device units")] RECTL rclBounds;
	long xDest;
	long yDest;
	long xSrc;
	long ySrc;
	long cxSrc;
	long cySrc;
	[helpstring("Offset to the source BITMAPINFO structure")] DWORD offBmiSrc;
	[helpstring("Size of the source BITMAPINFO structure")] DWORD cbBmiSrc;
	[helpstring("Offset to the source bitmap bits")] DWORD offBitsSrc;
	[helpstring("Size of the source bitmap bits")] DWORD cbBitsSrc;
	[helpstring("Source bitmap info color table usage")] DWORD iUsageSrc;
	DWORD dwRop;
	long cxDest;
	long cyDest;
} EMRSTRETCHDIBITS;
'!
!EMRSTRETCHDIBITS categoriesForClass!Win32-Structs! !
!EMRSTRETCHDIBITS methodsFor!

cbBitsSrc
	"Answer the receiver's cbBitsSrc field as a Smalltalk object."

	^bytes dwordAtOffset: ##(self offsetOf: #cbBitsSrc)!

cbBitsSrc: anObject 
	"Set the receiver's cbBitsSrc field to the value of anObject."

	bytes dwordAtOffset: ##(self offsetOf: #cbBitsSrc) put: anObject!

cbBmiSrc
	"Answer the receiver's cbBmiSrc field as a Smalltalk object."

	^bytes dwordAtOffset: ##(self offsetOf: #cbBmiSrc)!

cbBmiSrc: anObject 
	"Set the receiver's cbBmiSrc field to the value of anObject."

	bytes dwordAtOffset: ##(self offsetOf: #cbBmiSrc) put: anObject!

cxDest
	"Answer the receiver's cxDest field as a Smalltalk object."

	^bytes sdwordAtOffset: ##(self offsetOf: #cxDest)!

cxDest: anObject 
	"Set the receiver's cxDest field to the value of anObject."

	bytes sdwordAtOffset: ##(self offsetOf: #cxDest) put: anObject!

cxSrc
	"Answer the receiver's cxSrc field as a Smalltalk object."

	^bytes sdwordAtOffset: ##(self offsetOf: #cxSrc)!

cxSrc: anObject 
	"Set the receiver's cxSrc field to the value of anObject."

	bytes sdwordAtOffset: ##(self offsetOf: #cxSrc) put: anObject!

cyDest
	"Answer the receiver's cyDest field as a Smalltalk object."

	^bytes sdwordAtOffset: ##(self offsetOf: #cyDest)!

cyDest: anObject 
	"Set the receiver's cyDest field to the value of anObject."

	bytes sdwordAtOffset: ##(self offsetOf: #cyDest) put: anObject!

cySrc
	"Answer the receiver's cySrc field as a Smalltalk object."

	^bytes sdwordAtOffset: ##(self offsetOf: #cySrc)!

cySrc: anObject 
	"Set the receiver's cySrc field to the value of anObject."

	bytes sdwordAtOffset: ##(self offsetOf: #cySrc) put: anObject!

dwRop
	"Answer the receiver's dwRop field as a Smalltalk object."

	^bytes dwordAtOffset: ##(self offsetOf: #dwRop)!

dwRop: anObject 
	"Set the receiver's dwRop field to the value of anObject."

	bytes dwordAtOffset: ##(self offsetOf: #dwRop) put: anObject!

iUsageSrc
	"Answer the receiver's iUsageSrc field as a Smalltalk object."

	^bytes dwordAtOffset: ##(self offsetOf: #iUsageSrc)!

iUsageSrc: anObject 
	"Set the receiver's iUsageSrc field to the value of anObject."

	bytes dwordAtOffset: ##(self offsetOf: #iUsageSrc) put: anObject!

offBitsSrc
	"Answer the receiver's offBitsSrc field as a Smalltalk object."

	^bytes dwordAtOffset: ##(self offsetOf: #offBitsSrc)!

offBitsSrc: anObject 
	"Set the receiver's offBitsSrc field to the value of anObject."

	bytes dwordAtOffset: ##(self offsetOf: #offBitsSrc) put: anObject!

offBmiSrc
	"Answer the receiver's offBmiSrc field as a Smalltalk object."

	^bytes dwordAtOffset: ##(self offsetOf: #offBmiSrc)!

offBmiSrc: anObject 
	"Set the receiver's offBmiSrc field to the value of anObject."

	bytes dwordAtOffset: ##(self offsetOf: #offBmiSrc) put: anObject!

rclBounds
	"Answer the receiver's rclBounds field as a Smalltalk object."

	^RECT fromAddress: bytes yourAddress + ##(self offsetOf: #rclBounds)!

rclBounds: anObject 
	"Set the receiver's rclBounds field to the value of anObject."

	anObject 
		replaceBytesOf: bytes
		from: ##((self offsetOf: #rclBounds) + 1)
		to: ##((self offsetOf: #rclBounds) + RECT basicByteSize)
		startingAt: 1!

xDest
	"Answer the receiver's xDest field as a Smalltalk object."

	^bytes sdwordAtOffset: ##(self offsetOf: #xDest)!

xDest: anObject 
	"Set the receiver's xDest field to the value of anObject."

	bytes sdwordAtOffset: ##(self offsetOf: #xDest) put: anObject!

xSrc
	"Answer the receiver's xSrc field as a Smalltalk object."

	^bytes sdwordAtOffset: ##(self offsetOf: #xSrc)!

xSrc: anObject 
	"Set the receiver's xSrc field to the value of anObject."

	bytes sdwordAtOffset: ##(self offsetOf: #xSrc) put: anObject!

yDest
	"Answer the receiver's yDest field as a Smalltalk object."

	^bytes sdwordAtOffset: ##(self offsetOf: #yDest)!

yDest: anObject 
	"Set the receiver's yDest field to the value of anObject."

	bytes sdwordAtOffset: ##(self offsetOf: #yDest) put: anObject!

ySrc
	"Answer the receiver's ySrc field as a Smalltalk object."

	^bytes sdwordAtOffset: ##(self offsetOf: #ySrc)!

ySrc: anObject 
	"Set the receiver's ySrc field to the value of anObject."

	bytes sdwordAtOffset: ##(self offsetOf: #ySrc) put: anObject! !
!EMRSTRETCHDIBITS categoriesFor: #cbBitsSrc!**compiled accessors**!public! !
!EMRSTRETCHDIBITS categoriesFor: #cbBitsSrc:!**compiled accessors**!public! !
!EMRSTRETCHDIBITS categoriesFor: #cbBmiSrc!**compiled accessors**!public! !
!EMRSTRETCHDIBITS categoriesFor: #cbBmiSrc:!**compiled accessors**!public! !
!EMRSTRETCHDIBITS categoriesFor: #cxDest!**compiled accessors**!public! !
!EMRSTRETCHDIBITS categoriesFor: #cxDest:!**compiled accessors**!public! !
!EMRSTRETCHDIBITS categoriesFor: #cxSrc!**compiled accessors**!public! !
!EMRSTRETCHDIBITS categoriesFor: #cxSrc:!**compiled accessors**!public! !
!EMRSTRETCHDIBITS categoriesFor: #cyDest!**compiled accessors**!public! !
!EMRSTRETCHDIBITS categoriesFor: #cyDest:!**compiled accessors**!public! !
!EMRSTRETCHDIBITS categoriesFor: #cySrc!**compiled accessors**!public! !
!EMRSTRETCHDIBITS categoriesFor: #cySrc:!**compiled accessors**!public! !
!EMRSTRETCHDIBITS categoriesFor: #dwRop!**compiled accessors**!public! !
!EMRSTRETCHDIBITS categoriesFor: #dwRop:!**compiled accessors**!public! !
!EMRSTRETCHDIBITS categoriesFor: #iUsageSrc!**compiled accessors**!public! !
!EMRSTRETCHDIBITS categoriesFor: #iUsageSrc:!**compiled accessors**!public! !
!EMRSTRETCHDIBITS categoriesFor: #offBitsSrc!**compiled accessors**!public! !
!EMRSTRETCHDIBITS categoriesFor: #offBitsSrc:!**compiled accessors**!public! !
!EMRSTRETCHDIBITS categoriesFor: #offBmiSrc!**compiled accessors**!public! !
!EMRSTRETCHDIBITS categoriesFor: #offBmiSrc:!**compiled accessors**!public! !
!EMRSTRETCHDIBITS categoriesFor: #rclBounds!**compiled accessors**!public! !
!EMRSTRETCHDIBITS categoriesFor: #rclBounds:!**compiled accessors**!public! !
!EMRSTRETCHDIBITS categoriesFor: #xDest!**compiled accessors**!public! !
!EMRSTRETCHDIBITS categoriesFor: #xDest:!**compiled accessors**!public! !
!EMRSTRETCHDIBITS categoriesFor: #xSrc!**compiled accessors**!public! !
!EMRSTRETCHDIBITS categoriesFor: #xSrc:!**compiled accessors**!public! !
!EMRSTRETCHDIBITS categoriesFor: #yDest!**compiled accessors**!public! !
!EMRSTRETCHDIBITS categoriesFor: #yDest:!**compiled accessors**!public! !
!EMRSTRETCHDIBITS categoriesFor: #ySrc!**compiled accessors**!public! !
!EMRSTRETCHDIBITS categoriesFor: #ySrc:!**compiled accessors**!public! !

!EMRSTRETCHDIBITS class methodsFor!

defineFields
	"Define the fields of the EMRSTRETCHDIBITS structure.

	EMRSTRETCHDIBITS  compileDefinition

		typedef [uuid(BFCC8077-E3D1-4F40-81C8-B36128972F7A)]
		struct tagEMRSTRETCHDIBITS {
			EMR EMR;
			[helpstring('Inclusive-inclusive bounds in device units')] RECTL rclBounds;
			long xDest;
			long yDest;
			long xSrc;
			long ySrc;
			long cxSrc;
			long cySrc;
			[helpstring('Offset to the source BITMAPINFO structure')] DWORD offBmiSrc;
			[helpstring('Size of the source BITMAPINFO structure')] DWORD cbBmiSrc;
			[helpstring('Offset to the source bitmap bits')] DWORD offBitsSrc;
			[helpstring('Size of the source bitmap bits')] DWORD cbBitsSrc;
			[helpstring('Source bitmap info color table usage')] DWORD iUsageSrc;
			DWORD dwRop;
			long cxDest;
			long cyDest;
		} EMRSTRETCHDIBITS;
"

	super defineFields.
	self
		defineField: #rclBounds
			type: (StructureField type: RECT)
			offset: 8;
		defineField: #xDest
			type: SDWORDField new
			offset: 24;
		defineField: #yDest
			type: SDWORDField new
			offset: 28;
		defineField: #xSrc
			type: SDWORDField new
			offset: 32;
		defineField: #ySrc
			type: SDWORDField new
			offset: 36;
		defineField: #cxSrc
			type: SDWORDField new
			offset: 40;
		defineField: #cySrc
			type: SDWORDField new
			offset: 44;
		defineField: #offBmiSrc
			type: DWORDField new
			offset: 48;
		defineField: #cbBmiSrc
			type: DWORDField new
			offset: 52;
		defineField: #offBitsSrc
			type: DWORDField new
			offset: 56;
		defineField: #cbBitsSrc
			type: DWORDField new
			offset: 60;
		defineField: #iUsageSrc
			type: DWORDField new
			offset: 64;
		defineField: #dwRop
			type: DWORDField new
			offset: 68;
		defineField: #cxDest
			type: SDWORDField new
			offset: 72;
		defineField: #cyDest
			type: SDWORDField new
			offset: 76.
	self byteSize: 80!

iTypes
	"Answer the integer enhanced metafile record type id for this record class."

	^Array with: EMR_STRETCHDIBITS! !
!EMRSTRETCHDIBITS class categoriesFor: #defineFields!**auto generated**!initializing!public! !
!EMRSTRETCHDIBITS class categoriesFor: #iTypes!constants!public! !

