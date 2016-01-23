#include <MsgBoxConstants.au3>

; COM Test file
;
; Excel Automation Example

; NOTE: This will open an existing instance of Excel

; So Excel must be started first!!

Local $oExcel = ObjGet("", "Excel.Application") ; Get an existing Excel Object

If @error Then
	MsgBox($MB_SYSTEMMODAL, "ExcelFileTest", "You don't have Excel running at this moment. Error code: " & Hex(@error, 8))
	Exit
EndIf

If IsObj($oExcel) Then MsgBox($MB_SYSTEMMODAL, "", "You successfully attached to the existing Excel Application.")

$oExcel.Visible = 1 ; Let the guy show himself

$oExcel.workbooks.add ; Add a new workbook

; Example: Fill some cells

MsgBox($MB_SYSTEMMODAL, "", "Click 'ok' to fill some cells")

Local $i
Local $j

With $oExcel.activesheet
	For $i = 1 To 15
		For $j = 1 To 15
			.cells($i, $j).value = $i
		Next
	Next

	MsgBox($MB_SYSTEMMODAL, "", "Click 'ok' to clear the cells")
	.range("A1:O15").clear

EndWith

Sleep(2000)

$oExcel.activeworkbook.saved = 1 ; To prevent 'yes/no' questions from Excel

$oExcel.quit ; Get rid of him.

MsgBox($MB_SYSTEMMODAL, "", "Is Excel gone now??") ; Nope, should be still in memory.

$oExcel = 0 ; Loose the object

Exit
