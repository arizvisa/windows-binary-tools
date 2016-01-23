#include <MsgBoxConstants.au3>

Example()

Func Example()
	; Note: "b" is the symbol for byte.

	; Assign a Local variable the bitwise left-shift operation of 2.
	Local $iBitShift1 = BitShift(2, -1) ; 2 = 0010b left-shifted once -> 4 = 0100b

	; Note: It is equivalent to do this: BitRotate(2, 1)

	; Display the result.
	MsgBox($MB_SYSTEMMODAL, "", $iBitShift1)

	; Assign a Local variable the bitwise right-shift operation of 1.
	Local $iBitShift2 = BitShift(1, 1) ; 1 = 0001b right-shifted once -> 0 = 0000b

	; Display the result.
	MsgBox($MB_SYSTEMMODAL, "", $iBitShift2)

	; Assign a Local variable the bitwise left-shift operation of 14.
	Local $iBitShift3 = BitShift(14, -2) ; 14 = 1110b left-shifted twice -> 56 = 0011 1000b

	; Display the result.
	MsgBox($MB_SYSTEMMODAL, "", $iBitShift3)

	; Assign a Local variable the bitwise
	Local $iBitShift4 = BitShift(1, -31)
	;1 = 0001b right-shifted 31 times -> -2147483648 (32 bits) = 1000 0000 0000 0000 0000 0000 0000 0000b

	;Note: in 2's-complement notation, the 32nd digit from the right has a negative sign.

	; Display the result.
	MsgBox($MB_SYSTEMMODAL, "", $iBitShift4)
EndFunc   ;==>Example
