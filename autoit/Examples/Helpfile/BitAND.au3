#include <MsgBoxConstants.au3>

Example()

Func Example()
	; Note: "b" is the symbol for byte.

	; Assign a Local variable the bitwise AND operation of 1 and 0.
	Local $iBitAND1 = BitAND(1, 0)

	; Display the result.
	MsgBox($MB_SYSTEMMODAL, "", $iBitAND1)

	; Assign a Local variable the bitwise AND operation of 1 and 1.
	Local $iBitAND2 = BitAND(1, 1)

	; Display the result.
	MsgBox($MB_SYSTEMMODAL, "", $iBitAND2)

	; Assign a Local variable the bitwise AND operation of 13 (1101b) and 7 (0111b).
	Local $iBitAND3 = BitAND(13, 7) ; 1101b AND 0111b = 0101b

	; Display the result.
	MsgBox($MB_SYSTEMMODAL, "", $iBitAND3)

	; Assign a Local variable the bitwise AND operation of 2 (0010b), 3 (0011b) and 6 (0110b).
	Local $iBitAND4 = BitAND(2, 3, 6) ; 0010b AND 0011b AND 0110b = 0010b

	; Display the result.
	MsgBox($MB_SYSTEMMODAL, "", $iBitAND4)
EndFunc   ;==>Example
