#include <MsgBoxConstants.au3>

Sleep(1000) ; Allow time for the cursor to change its state.

; Create an array of possible cursor states using StringSplit.
Local $aArray = StringSplit("Hand|AppStarting|Arrow|Cross|Help|IBeam|Icon (obsolete)|No|" & _
		"Size (obsolete)|SizeAll|SizeNESW|SizeNS|SizeNWSE|SizeWE|UpArrow|Wait|Empty", "|", 2) ; The flag parameter is set to flag = 2 as we don't require the total count of the array.
#cs
	The array returned will contain the following values:
	$aArray[0] = "Hand"
	$aArray[1] = "AppStarting"
	$aArray[2] = "Arrow"
	...
	$aArray[16] = "Empty"
#ce

Local $iCursor = MouseGetCursor()
MsgBox($MB_SYSTEMMODAL, "CursorID = " & $iCursor, "Which means " & $aArray[$iCursor] & ".") ; Use the CursorID value as the index value of the array
