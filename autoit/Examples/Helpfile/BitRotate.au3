#include <MsgBoxConstants.au3>

Example()

Func Example()
	; Note: "b" is the symbol for byte.

	; Assign a Local variable the bitwise left-rotate operation of 2.
	Local $iBitRotate1 = BitRotate(2, 1) ; 2 = 0010b left-rotated once -> 4 = 0100b

	; Note: It is equivalent to do this: BitShift(2, -1)

	; Display the result.
	MsgBox($MB_SYSTEMMODAL, "", $iBitRotate1)

	; Assign a Local variable the bitwise right-rotate operation of 1.
	Local $iBitRotate2 = BitRotate(1, -1) ; 1 = 0001b right-rotated once -> 32768 (32 bits) = 1000 0000 0000 0000b

	; Display the result.
	MsgBox($MB_SYSTEMMODAL, "", $iBitRotate2)

	; Assign a Local variable the bitwise right-rotate operation of 14.
	Local $iBitRotate3 = BitRotate(14, -2) ; 14 = 1110b right-rotated twice -> 32771 (16 bits) = 1000 0000 0000 0011b

	; Display the result.
	MsgBox($MB_SYSTEMMODAL, "", $iBitRotate3)

	; Assign a Local variable the bitwise right-rotate operation of 14 on 32 bits.
	Local $iBitRotate4 = BitRotate(14, -2, "D")
	; 14 = 1110b right-rotated twice -> -2147483645 (32 bits) = 1000 0000 0000 0000 0000 0000 0000 0011b (the first bit is signed)

	; Display the result.
	MsgBox($MB_SYSTEMMODAL, "", $iBitRotate4)
EndFunc   ;==>Example
