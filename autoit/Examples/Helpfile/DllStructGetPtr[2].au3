#include <MsgBoxConstants.au3>

Example()

Func Example()
	; Assign a Local variable a structure with the definition of an int.
	Local $tSTRUCT1 = DllStructCreate("int")
	Local $iError = 0

	; If an error occurred display the error code and return False.
	If @error Then
		$iError = @error
		MsgBox(BitOR($MB_SYSTEMMODAL, $MB_ICONHAND), Default, "Error in DllCall, Code: " & $iError)
		Return False
	EndIf

	; Assign a Local variable the tSTRUCT1 structure except that the elements will be got according to the new definition.
	Local $tSTRUCT2 = DllStructCreate("uint", DllStructGetPtr($tSTRUCT1, 1))

	; If an error occurred display the error code and return False.
	If @error Then
		$iError = @error
		MsgBox(BitOR($MB_SYSTEMMODAL, $MB_ICONHAND), Default, "Error in DllCall, Code: " & $iError)
		Return False
	EndIf

	Local $tSTRUCT3 = DllStructCreate("float", DllStructGetPtr($tSTRUCT1, 1))

	; If an error occurred display the error code and return False.
	If @error Then
		$iError = @error
		MsgBox(BitOR($MB_SYSTEMMODAL, $MB_ICONHAND), Default, "Error in DllCall, Code: " & $iError)
		Return False
	EndIf

	; Notes: -The structures points to the same structure (they have the same pointer);
	; The first element got with the:
	; *tSTRUCT1 struct will be an int.
	; *tSTRUCT2 struct will be an unsigned int (the element is casted from int to uint).
	; *tSTRUCT3 struct will be a float (the element is casted from int to float).
	;
	; -The "reinterpret_cast" casting operator is used.

	; Set the data of the first element (int) in the $tSTRUCT1.
	DllStructSetData($tSTRUCT1, 1, -1)

	; Display the different data types of the same data.
	MsgBox($MB_SYSTEMMODAL, "", _
			"int: " & DllStructGetData($tSTRUCT1, 1) & @CRLF & _
			"uint: " & DllStructGetData($tSTRUCT2, 1) & @CRLF & _
			"float: " & DllStructGetData($tSTRUCT3, 1))

	; Release the resources used by the structures.
	$tSTRUCT1 = 0
	$tSTRUCT2 = 0
	$tSTRUCT3 = 0
EndFunc   ;==>Example
