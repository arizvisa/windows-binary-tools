; Get a reference to the collection of forms on a page,
; and then loop through them displaying information for each

#include <IE.au3>
#include <MsgBoxConstants.au3>

Local $oIE = _IECreate("http://www.autoitscript.com")
Local $oForms = _IEFormGetCollection($oIE)
MsgBox($MB_SYSTEMMODAL, "Forms Info", "There are " & @extended & " form(s) on this page")
For $oForm In $oForms
	MsgBox($MB_SYSTEMMODAL, "Form Info", $oForm.name)
Next
