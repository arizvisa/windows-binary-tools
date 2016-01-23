#include <MsgBoxConstants.au3>

Example()

Func Example()
	; Note: "b" is the symbol for byte.

	; Assign a Local variable the bitwise OR operation of 1 and 0.
	Local $iBitOR1 = BitOR(1, 0) ; 0001b OR 0000b = 0001b

	; Display the result.
	MsgBox($MB_SYSTEMMODAL, "", $iBitOR1)

	; Assign a Local variable the bitwise OR operation of 1 and 1.
	Local $iBitOR2 = BitOR(1, 1) ; 0001b OR 0001b = 0001b

	; Display the result.
	MsgBox($MB_SYSTEMMODAL, "", $iBitOR2)

	; Assign a Local variable the bitwise OR operation of 13 (1101b) and 7 (0111b).
	Local $iBitOR3 = BitOR(13, 7) ; 1101b OR 0111b = 1111b

	; Display the result.
	MsgBox($MB_SYSTEMMODAL, "", $iBitOR3)

	; Assign a Local variable the bitwise OR operation of 2 (0010b), 3 (0011b) and 6 (0110b).
	Local $iBitOR4 = BitOR(2, 3, 6) ; 0010b OR 0011b OR 0110b = 0111b

	; Display the result.
	MsgBox($MB_SYSTEMMODAL, "", $iBitOR4)
EndFunc   ;==>Example
