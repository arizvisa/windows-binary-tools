#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $iValue = 0
	Local $sBlank = "Test"

	Select
		Case $iValue = 1
			MsgBox($MB_SYSTEMMODAL, "", "The first expression was True.")
		Case $sBlank = "Test"
			MsgBox($MB_SYSTEMMODAL, "", "The second expression was True")
		Case Else ; If nothing matches then execute the following.
			MsgBox($MB_SYSTEMMODAL, "", "No preceding case was True.")
	EndSelect
EndFunc   ;==>Example
