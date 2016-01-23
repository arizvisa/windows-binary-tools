; Get a reference to the collection of forms on a page,
; and then loop through them displaying information for each
; demonstrating use of form index

#include <IE.au3>
#include <MsgBoxConstants.au3>

Local $oIE = _IECreate("http://www.autoitscript.com")
Local $oForms = _IEFormGetCollection($oIE)
Local $iNumForms = @extended
MsgBox($MB_SYSTEMMODAL, "Forms Info", "There are " & $iNumForms & " forms on this page")
Local $oForm
For $i = 0 To $iNumForms - 1
	$oForm = _IEFormGetCollection($oIE, $i)
	MsgBox($MB_SYSTEMMODAL, "Form Info", $oForm.name)
Next
