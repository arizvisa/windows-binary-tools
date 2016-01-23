; Open a browser with the form example, get reference to form, get reference
; to select element, check to see if the option "Freepage" is selected and
; report result.  Repeat for the option with index 0 and for the option
; with value of 'midipage.html'

#include <IE.au3>
#include <MsgBoxConstants.au3>

Local $oIE = _IE_Example("form")
Local $oForm = _IEFormGetObjByName($oIE, "ExampleForm")
Local $oSelect = _IEFormElementGetObjByName($oForm, "selectExample")
If _IEFormElementOptionSelect($oSelect, "Freepage", -1, "byText") Then
	MsgBox($MB_SYSTEMMODAL, "Option Selected", "Option Freepage is selected")
Else
	MsgBox($MB_SYSTEMMODAL, "Option Selected", "Option Freepage is Not selected")
EndIf
If _IEFormElementOptionSelect($oSelect, 0, -1, "byIndex") Then
	MsgBox($MB_SYSTEMMODAL, "Option Selected", "The First (index 0) option is selected")
Else
	MsgBox($MB_SYSTEMMODAL, "Option Selected", "The First (index 0) option is Not selected")
EndIf
If _IEFormElementOptionSelect($oSelect, "midipage.html", -1, "byValue") Then
	MsgBox($MB_SYSTEMMODAL, "Option Selected", "The option with value 'midipage.html' is selected")
Else
	MsgBox($MB_SYSTEMMODAL, "Option Selected", "The option with value 'midipage.html' is NOT selected")
EndIf

_IEQuit($oIE)
