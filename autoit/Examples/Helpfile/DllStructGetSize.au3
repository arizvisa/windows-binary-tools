#include <MsgBoxConstants.au3>

Example()

Func Example()
	; Assign a Local constant variable the definition of a structure.
	Local Const $tagSTRUCT1 = "struct;int var1;byte var2;uint var3;char var4[128];endstruct"

	; Assign a Local variable the structure.
	Local $tSTRUCT1 = DllStructCreate($tagSTRUCT1)

	; If an error occurred display the error code and return False.
	If @error Then
		MsgBox($MB_SYSTEMMODAL, "", "Error in DllStructCreate, Code: " & @error)
		Return False
	EndIf

	#cs Comments:
	-The default alignment for the data is 4 bytes, thus each element will take at least 4 bytes.
	-The min size can be obtained by setting an alignment of 1 at the beginning of the struct definition: "align 1;struct; ..."

	-Detailed information on the struct size:
	var1: int - 4 bytes
	var2: byte - 1 byte + 3 bytes alignment = 4 bytes
	var3: uint - 4 bytes
	var4: char[128] - 1 * 128 bytes
	#ce

	MsgBox($MB_SYSTEMMODAL, "", "Struct Size: " & DllStructGetSize($tSTRUCT1))
EndFunc   ;==>Example
