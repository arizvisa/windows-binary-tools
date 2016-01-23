#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $sName = InputBox("", "Please enter a word.", "", " M", Default, Default, Default, Default, 10)
	Local $sMsg = ""

	Switch @error
		Case 2
			$sMsg = "Timeout "
			ContinueCase
		Case 1 ; Continuing previous case
			$sMsg &= "Cancellation"
		Case 0
			Switch $sName
				Case "a", "e", "i", "o", "u"
					$sMsg = "Vowel"
				Case "QP"
					$sMsg = "Mathematics"
				Case "Q" To "QZ"
					$sMsg = "Science"
				Case Else
					$sMsg = "Others"
			EndSwitch
		Case Else
			$sMsg = "Something went horribly wrong."
	EndSwitch

	MsgBox($MB_SYSTEMMODAL, "", $sMsg)
EndFunc   ;==>Example
