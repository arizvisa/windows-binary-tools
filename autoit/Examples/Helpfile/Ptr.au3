#include <MsgBoxConstants.au3>

Example()

Func Example()
	; Convert -1 to a pointer expression.
	Local $pPtr = Ptr(-1)

	; Test if $hPtr is a valid pointer and display the results.
	If IsPtr($pPtr) Then
		MsgBox($MB_SYSTEMMODAL, "", "It's a valid Ptr")
	Else
		MsgBox($MB_SYSTEMMODAL, "", "It's not a valid Ptr")
	EndIf
EndFunc   ;==>Example
