#include <MsgBoxConstants.au3>

Example()

Func Example()
	#cs Comments:
	Create the following structure (C language):
	struct {
		int var1;
		unsigned char var2;
		unsigned int var3;
		char var4[128];
	};

	Schema:
	------------------------------------
	\ int    \ byte   \ uint   \ char   \
	 \   var1 \   var2 \   var3 \   var4 \
	  ------------------------------------
	#ce

	; Assign a Local constant variable the definition of a structure (read carefully the DllStructCreate remarks).
	Local Const $tagSTRUCT1 = "struct;int var1;byte var2;uint var3;char var4[128];endstruct"

	; Note: The tag variable is declared as Constant because its value will never change for any script execution.

	; Assign a Local variable the structure.
	Local $tSTRUCT1 = DllStructCreate($tagSTRUCT1)

	; If an error occurred display the error code and return False.
	If @error Then
		MsgBox($MB_SYSTEMMODAL, "", "Error in DllStructCreate, Code: " & @error)
		Return False
	EndIf

	; Set the data of the element var1 (int) in the $tSTRUCT1.
	DllStructSetData($tSTRUCT1, "var1", -1) ; Or 1 instead of "var1".

	; Set the data of the element var2 (byte) in the $tSTRUCT1.
	DllStructSetData($tSTRUCT1, 2, 255) ; Or "var2" instead of 2.

	; Set the data of the element var3 (uint) in the $tSTRUCT1.
	DllStructSetData($tSTRUCT1, "var3", -1) ; The -1 (signed int) will be typecasted to unsigned int.
	; Or 3 instead of "var3".

	; Set the data of the element var4 (char) in the $tSTRUCT1.
	DllStructSetData($tSTRUCT1, "var4", "Hello") ; Or 4 instead of "var4".

	; Note: This element can contain up to 128 characters.

	; Change the data of the element var4 (char) in the $tSTRUCT1, at the index 1 of the char array (1 based index).
	DllStructSetData($tSTRUCT1, "var4", Asc("h"), 1)

	; Display the results.
	MsgBox($MB_SYSTEMMODAL, "", "Struct Size: " & DllStructGetSize($tSTRUCT1) & @CRLF & _
			"Struct pointer: " & DllStructGetPtr($tSTRUCT1) & @CRLF & _
			"Data:" & @CRLF & _
			DllStructGetData($tSTRUCT1, 1) & @CRLF & _ ; Or "var1" instead of 1.
			DllStructGetData($tSTRUCT1, "var2") & @CRLF & _ ; Or 2 instead of "var2".
			DllStructGetData($tSTRUCT1, 3) & @CRLF & _ ; Or "var3" instead of 3.
			DllStructGetData($tSTRUCT1, 4)) ; Or "var4" instead of 4.

	; Release the resources used by the structure.
	$tSTRUCT1 = 0
EndFunc   ;==>Example
