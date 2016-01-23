; Attempt to attach to an existing browser displaying a particular website URL
; Create a new browser and navigate to that site if one does not already exist

#include <IE.au3>
#include <MsgBoxConstants.au3>

Local $oIE = _IECreate("www.autoitscript.com", 1)
; Check @extended return value to see if attach was successful
If @extended Then
	MsgBox($MB_SYSTEMMODAL, "", "Attached to Existing Browser")
Else
	MsgBox($MB_SYSTEMMODAL, "", "Created New Browser")
EndIf
