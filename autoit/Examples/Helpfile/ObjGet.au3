#include <MsgBoxConstants.au3>

; Example getting an Object using it's class name
; ; Excel must be activated for this example to be successful

Example()

Func Example()
	Local $oExcel = ObjGet("", "Excel.Application") ; Get an existing Excel Object

	If @error Then
		MsgBox($MB_SYSTEMMODAL, "", "Excel File Test" & @CRLF & "Error Getting an active Excel Object. Error code: " & Hex(@error, 8))
		Return False
	EndIf

	$oExcel.Visible = 1 ; Let the guy show himself
	$oExcel.workbooks.add ; Add a new workbook
EndFunc   ;==>Example
