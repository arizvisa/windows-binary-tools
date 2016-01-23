#include <MsgBoxConstants.au3>

Example()

Func Example()
	; Note: "b" is the symbol for byte.

	; Assign a Local variable the bitwise XOR operation of 1 and 0.
	Local $iBitXOR1 = BitXOR(1, 0) ; 0001b XOR 0000b = 0001b

	; Display the result.
	MsgBox($MB_SYSTEMMODAL, "", $iBitXOR1)

	; Assign a Local variable the bitwise XOR operation of 1 and 1.
	Local $iBitXOR2 = BitXOR(1, 1) ; 0001b XOR 0001b = 0000b

	; Display the result.
	MsgBox($MB_SYSTEMMODAL, "", $iBitXOR2)

	; Assign a Local variable the bitwise XOR operation of 13 (1101b) and 7 (0111b).
	Local $iBitXOR3 = BitXOR(13, 7) ; 1101b XOR 0111b = 1010b

	; Display the result.
	MsgBox($MB_SYSTEMMODAL, "", $iBitXOR3)

	; Assign a Local variable the bitwise XOR operation of 2 (0010b), 3 (0011b) and 6 (0110b).
	Local $iBitXOR4 = BitXOR(2, 3, 6) ; 0010b XOR 0011b XOR 0110b = 0111b

	; Display the result.
	MsgBox($MB_SYSTEMMODAL, "", $iBitXOR4)
EndFunc   ;==>Example
