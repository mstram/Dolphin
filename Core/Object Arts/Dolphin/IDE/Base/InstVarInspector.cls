"Filed out from Dolphin Smalltalk 7"!

AspectInspector subclass: #InstVarInspector
	instanceVariableNames: 'sourcePresenter'
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
InstVarInspector guid: (GUID fromString: '{da630ac4-c186-11d5-9849-0800460222f0}')!
InstVarInspector comment: ''!
!InstVarInspector categoriesForClass!Development!MVP-Resources-IDE Tools! !
!InstVarInspector methodsFor!

accept
	"Saves the current source as the value of the selected variable of the
	receivers object."

	"If there is no selection then the entire workspace is selected for consistency
	with saving method source. This also works rather better with word wrap too."

	| newObject oldObject |
	sourcePresenter view hasSelection ifFalse: [sourcePresenter view selectAll].

	"Evaluate the new value and keep a copy of the old value for undo purposes"
	newObject := sourcePresenter evaluateItIfFail: [^self].
	oldObject := self aspectValue.
	self setAspectValue: newObject.
	Command current undoWith: [self setAspectValue: oldObject]!

createComponents
	"Create the presenters contained by the receiver"

	super createComponents.
	sourcePresenter := self add: Smalltalk developmentSystem workspaceClass new name: 'source'!

defaultBatchSize
	"Answers the default batch size of the receiver, i.e. the number of keyed elements to return at a time"

	^500
!

displayOn: aStream
	"Append, to aStream, a String whose characters are a representation of the receiver as a user
	would want to see it. This will be used as the label for the tab when the receiver is being displayed
	within the Flipper Inspector"

	aStream nextPutAll: 'Instance Variables'!

getInstVarAccessorsOf: anInstVarAccessor 
	"Private - Answers an <Array> of  <InstVarAccessors> to show as children of anInstVarAccessor"

	| fixedPart indexedPart inspectee batchAccessor |
	inspectee := [anInstVarAccessor value] on: Error do: [:ex | ex].
	fixedPart := (1 to: inspectee class instSize) collect: 
					[:each | 
					| value aspect |
					value := inspectee instVarAt: each.
					aspect := value newAspect: each class: InstVarAspect.
					aspect accessorFor: inspectee].
	batchAccessor := IndexedInstVarBatchAccessor subject: inspectee batchSize: self defaultBatchSize.
	indexedPart := batchAccessor getBatchAccessors.
	^fixedPart , indexedPart!

inspecteeChanged
	"Private - The receiver's model has had the currently inspected instance variable updated. 
	Force the receiver to update the variableNamesPresenter appropriately and 
	trigger an #inspecteeChanged to inform our interested parties"

	self instVarUpdated: self aspectAccessor.
	self trigger: #inspecteeChanged!

inspectIt
	"Open a new Inspector on the variable selected in variablesModel."

	self aspectValue inspect!

instVarUpdated: anInstVarAccessor
	"Private - The instance variable identified by anInstVarAccessor has been updated. 
	Ensure that our aspect tree model is refreshed appropriately"

	aspectTreePresenter model collapse: anInstVarAccessor!

object
	"Answer the object inspected by the receiver."

	^self model value!

onAspectSelected
	"Private - The selection in the variablesModel has changed. Update the source presenter
	to show the value stored in the object at the selected variable."

	(aspectTreePresenter selectionIfNone: [^self]) selectIn: self!

onValueChanged
	"The object which is inspected by the receiver has been changed."

	self refresh!

queryCommand: query
	"Private - Enters details about a potential command for the receiver into the 
	<CommandQuery>,  query."

	| command accessor |
	command := query commandSymbol.
	accessor := self aspectAccessor.
	#accept == command 
		ifTrue: 
			[query isEnabled: (accessor notNil and: [accessor canSet]).
			^true].
	^super queryCommand: query!

refresh
	| instVarTreeModel inspectee accessor |
	inspectee := self object.
	accessor := (inspectee newAspect: 0 class: InstVarAspect) accessorFor: inspectee.
	instVarTreeModel := (ExpandingTreeModel withRoots: (Array with: accessor)) 
				getChildrenBlock: [:x | self getInstVarAccessorsOf: x].
	aspectTreePresenter
		model: instVarTreeModel;
		expand: accessor;
		selectionOrNil: accessor!

selectAspect: anAspectAccessor 
	| var |
	var := [anAspectAccessor value] on: Error do: [:ex | ex].
	sourcePresenter evaluationContext: var.
	sourcePresenter text: ([var printString] on: Error
				do: 
					[:e | 
					| name |
					name := anAspectAccessor name.
					self unableToDisplayVariableErrorFormatString 
						expandMacrosWith: name
						with: var class
						with: e description
						with: (name isInteger ifTrue: ['self basicAt: ' , name displayString] ifFalse: [name])])!

setAspectValue: anObject
	"Private - Set the value associated with the currently selected
	instance variable name to anObject."

	self aspectAccessor value: anObject.
	self inspecteeChanged!

unableToDisplayVariableErrorFormatString
	"Private - Answer the format string used to construct the error message text to be
	displayed in place of a variable value when a variable is selected that cannot be
	printed."

	^'an invalid <2p> [<3s>]<n><n>Evaluate the following expression to debug:<n><t>self printString'! !
!InstVarInspector categoriesFor: #accept!commands!public! !
!InstVarInspector categoriesFor: #createComponents!initializing!public! !
!InstVarInspector categoriesFor: #defaultBatchSize!constants!private! !
!InstVarInspector categoriesFor: #displayOn:!displaying!public! !
!InstVarInspector categoriesFor: #getInstVarAccessorsOf:!accessing!private! !
!InstVarInspector categoriesFor: #inspecteeChanged!private!updating! !
!InstVarInspector categoriesFor: #inspectIt!commands!public! !
!InstVarInspector categoriesFor: #instVarUpdated:!private!updating! !
!InstVarInspector categoriesFor: #object!accessing!public! !
!InstVarInspector categoriesFor: #onAspectSelected!event handling!private! !
!InstVarInspector categoriesFor: #onValueChanged!accessing!public! !
!InstVarInspector categoriesFor: #queryCommand:!commands!private! !
!InstVarInspector categoriesFor: #refresh!commands!public!updating! !
!InstVarInspector categoriesFor: #selectAspect:!event handling!private! !
!InstVarInspector categoriesFor: #setAspectValue:!accessing!private! !
!InstVarInspector categoriesFor: #unableToDisplayVariableErrorFormatString!constants!private! !

!InstVarInspector class methodsFor!

initialize
	"Private - Initialize the receiver's class variables.
		self initialize
	"

	Smalltalk developmentSystem registerTool: self.
	treeUpdateMode := #dynamic.
	treeHasGridLines := false!

resource_Default_view
	"Answer the literal data from which the 'Default view' resource can be reconstituted.
	DO NOT EDIT OR RECATEGORIZE THIS METHOD.

	If you wish to modify this resource evaluate:
	ViewComposer openOn: (ResourceIdentifier class: self selector: #resource_Default_view)
	"

	^#(#'!!STL' 4 788558 10 ##(Smalltalk.STBViewProxy) ##(Smalltalk.ContainerView) 34 15 0 0 34 2 8 1409286144 131073 416 0 524550 ##(Smalltalk.ColorRef) 8 4278190080 0 5 0 0 0 416 1180166 ##(Smalltalk.ProportionalLayout) 138 ##(Smalltalk.Dictionary) 34 3 721414 ##(Smalltalk.Association) 410 ##(Smalltalk.ReferenceView) 34 14 0 416 34 2 8 1140850688 131073 624 0 0 0 5 0 0 0 624 1180166 ##(Smalltalk.ResourceIdentifier) ##(Smalltalk.SmalltalkWorkspace) #resource_Default_view 0 983302 ##(Smalltalk.MessageSequence) 138 144 34 1 721670 ##(Smalltalk.MessageSend) #createAt:extent: 34 2 328198 ##(Smalltalk.Point) 591 1 834 291 591 624 983302 ##(Smalltalk.WINDOWPLACEMENT) 8 #[44 0 0 0 0 0 0 0 1 0 0 0 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 39 1 0 0 0 0 0 0 184 1 0 0 39 1 0 0] 8 #() 834 193 193 0 27 3 594 410 ##(Smalltalk.ListTreeView) 34 44 0 416 34 2 8 1140953421 1 976 590662 2 ##(Smalltalk.ListModel) 138 144 928 0 1310726 ##(Smalltalk.IdentitySearchPolicy) 482 8 4278190080 0 13 265030 4 ##(Smalltalk.Menu) 0 true 34 12 984134 2 ##(Smalltalk.CommandMenuItem) 1 1180998 4 ##(Smalltalk.CommandDescription) #inspectIt 8 '&Inspect' 1 1 263494 3 ##(Smalltalk.Icon) 0 true 1572870 ##(Smalltalk.ImageRelativeFileLocator) 8 'BasicInspector.ico' 2032142 ##(Smalltalk.STBExternalResourceLibraryProxy) 8 'dolphindr7.dll' 0 0 0 1202 1 1234 #inspectReferences 8 'Inspect &References' 1 1 0 0 0 983366 1 ##(Smalltalk.DividerMenuItem) 4097 1202 1 1234 #browseIt 8 '&Browse It' 1 1 1282 0 true 1328 8 'ClassBrowserShell.ico' 1376 0 0 1458 4097 1202 1 1234 #copyAspect 8 '&Copy' 1 1 0 0 0 1202 1 1234 #pasteAspect 8 '&Paste <1d>' 1 1 0 0 0 1458 4097 1202 1 1234 #editAspect 8 '&Edit' 1 1 0 0 0 1202 1 1234 #nilAspect 8 'Set to &Nil' 1 1 0 0 0 1458 4097 1202 1 1234 #refresh 8 'Re&fresh' 1 1 0 0 0 8 '&Workspace' 0 134217729 0 0 0 0 0 0 0 976 0 8 4294904511 459270 ##(Smalltalk.Message) #valueText 8 #() 0 1049926 1 ##(Smalltalk.IconImageManager) 0 0 0 0 0 0 138 144 34 3 920646 5 ##(Smalltalk.ListViewColumn) 8 'Instance Variable' 267 #left 787814 3 ##(Smalltalk.BlockClosure) 0 0 1180966 ##(Smalltalk.CompiledExpression) 2 1 2048 8 'doIt' 8 '[:x | x valueNameOnly]' 8 #[30 105 226 0 106] #valueNameOnly 2064 7 257 0 1890 #<= 8 #() 0 0 976 0 3 2050 0 0 2082 2 1 2048 8 'doIt' 8 '[:x | x valueNameInfo ]' 8 #[30 105 226 0 106] #valueNameInfo 2192 7 257 0 0 2002 8 'Value' 267 #left 2050 0 0 2082 2 1 2048 8 'doIt' 8 '[:x | x valueTextOnly ]' 8 #[30 105 226 0 106] #valueTextOnly 2304 7 257 0 1890 #<= 2176 0 0 976 2050 0 0 2082 2 1 2048 8 'doIt' 8 '[:x | x valueImage ]' 8 #[30 105 226 0 106] #valueImage 2400 7 257 0 3 0 0 2002 8 '' 41 #center 1890 #displayString 8 #() 1890 #<= 2528 0 0 976 2050 0 0 2082 3 1 2048 8 'doIt' 8 '[:x | PropertyInspector editButtonImageIndexFor: x ]' 8 #[31 105 29 17 177 106] ##(Smalltalk.PropertyInspector) #editButtonImageIndexFor: 2560 7 257 0 1 0 0 #report 928 0 133479 834 129 129 34 4 0 0 834 1 1 0 false 1050438 3 ##(Smalltalk.VirtualTreeModel) 0 1104 138 144 928 0 0 2050 0 0 918822 ##(Smalltalk.CompiledMethod) 2 3 2688 #defaultHasChildrenBlock 508791331 8 #[252 1 0 0 1 4 0 65 176 159 106 105] #childrenOf: #notEmpty 17 257 2704 2050 0 0 2754 1 83886083 2688 #defaultFilterBlock 508773827 8 #[29 105 17 157 106] 2800 7 257 0 0 138 ##(Smalltalk.PluggableSet) 928 138 ##(Smalltalk.PluggableSet) 928 13 5 0 0 0 0 0 0 0 722 138 144 34 3 786 #createAt:extent: 34 2 834 1 1 834 581 591 976 786 #contextMenu: 34 1 1168 976 786 #text: 34 1 8 'Instance Variable' 976 882 8 #[44 0 0 0 0 0 0 0 1 0 0 0 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 0 0 0 0 0 0 0 0 34 1 0 0 39 1 0 0] 8 #() 944 0 2021 5 594 410 ##(Smalltalk.Splitter) 34 12 0 416 34 2 8 1140850688 1 3136 0 482 512 0 517 0 0 0 3136 722 138 144 34 1 786 #createAt:extent: 34 2 834 581 1 834 11 591 3136 882 8 #[44 0 0 0 0 0 0 0 1 0 0 0 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 34 1 0 0 0 0 0 0 39 1 0 0 39 1 0 0] 8 #() 944 0 27 1 false 170 192 34 4 624 8 'source' 976 8 'aspects' 0 722 138 144 34 1 786 #createAt:extent: 34 2 834 2731 21 834 881 591 416 882 8 #[44 0 0 0 0 0 0 0 1 0 0 0 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 23 5 0 0 10 0 0 0 207 6 0 0 49 1 0 0] 34 3 976 3136 624 944 0 27 )! !
!InstVarInspector class categoriesFor: #initialize!initializing!private! !
!InstVarInspector class categoriesFor: #resource_Default_view!public!resources-views! !

