#include <MsgBoxConstants.au3>
#include <StructureConstants.au3>

Example()

Func Example()
	; Assign a Local variable the handle of the current active window.
	Local $hWnd = WinGetHandle("") ; Same as: "[active]".

	; Assign a Local variable the window's rectangle (array).
	Local $aWndPos = WinGetPos($hWnd)

	; Assign a Local variable the structure created with the tagRECT definition.
	Local $tRECT = DllStructCreate($tagRECT)
	Local $iError = 0

	; If an error occurred display the error code and return False.
	If @error Then
		$iError = @error
		MsgBox(BitOR($MB_SYSTEMMODAL, $MB_ICONHAND), Default, "Error in DllStructCreate, Code: " & $iError)
		Return False
	EndIf

	; Make the DllCall of the GetWindowRect function.
	DllCall("user32.dll", "int", "GetWindowRect", _
			"hwnd", $hWnd, _
			"ptr", DllStructGetPtr($tRECT))

	; If an error occurred display the error code and return False.
	If @error Then
		$iError = @error
		MsgBox(BitOR($MB_SYSTEMMODAL, $MB_ICONHAND), Default, "Error in DllCall, Code: " & $iError)
		Return False
	EndIf

	; Note: The 2nd parameter of the GetWindowRect function requires a pointer,
	; the result returned by the DllStructCreate is NOT a pointer, but using 'struct*' allows to pass a structure as a ptr.

	; Assign Local variables the returned rectangle.
	Local $iLeft = DllStructGetData($tRECT, "Left") ; Or 1 instead of "Left".
	Local $iTop = DllStructGetData($tRECT, 2) ; Or "Top" instead of 2.
	Local $iRight = DllStructGetData($tRECT, 3) ; Or "Right" instead of 3.
	Local $iBottom = DllStructGetData($tRECT, "Bottom") ; Or 4 instead of "Bottom".

	; Release the resources used by the structure.
	$tRECT = 0

	; Display the results of WinGetPos and the returned rectangle.
	MsgBox($MB_SYSTEMMODAL, "", "WinGetPos(): (" & $aWndPos[0] & ", " & $aWndPos[1] & ") " & _
			"(" & $aWndPos[2] + $aWndPos[0] & ", " & $aWndPos[3] + $aWndPos[1] & ")" & @CRLF & _
			"GetWindowRect(): (" & $iLeft & ", " & $iTop & ") (" & $iRight & ", " & $iBottom & ")")
EndFunc   ;==>Example
