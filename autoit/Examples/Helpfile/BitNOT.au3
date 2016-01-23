#include <MsgBoxConstants.au3>

; Assign a Local variable the bitwise NOT operation of 5.
Local $iBitNOT1 = BitNOT(5)

#cs Comments:
	Note: "b" is the symbol for byte.

	Result is -6 because for 32-bit numbers
	+5 == 0000 0000 0000 0000 0000 0000 0000 0101b
	-6 == 1111 1111 1111 1111 1111 1111 1111 1010b
	and the first bit is signed
#ce

; Display the result.
MsgBox($MB_SYSTEMMODAL, "", $iBitNOT1)
