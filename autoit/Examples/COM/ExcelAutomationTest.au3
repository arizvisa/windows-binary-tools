#include <MsgBoxConstants.au3>

; COM Test file
;
; Excel Automation Example
;

Local $oMyExcel = ObjCreate("Excel.Application") ; Create an Excel Object

If @error Then
	MsgBox($MB_SYSTEMMODAL, "ExcelTest", "Error creating the Excel Object. Error code: " & @error)
	Exit
EndIf

If Not IsObj($oMyExcel) Then
	MsgBox($MB_SYSTEMMODAL, "ExcelTest", "I'm sorry, but creation of the Excel object failed.")
	Exit
EndIf

$oMyExcel.Visible = 1 ; Let the guy show himself

$oMyExcel.workbooks.add ; Add a new workbook

; Example: Fill some cells

MsgBox($MB_SYSTEMMODAL, "", "Click 'ok' to fill some cells")

Local $i
Local $j

With $oMyExcel.activesheet
	For $i = 1 To 15
		For $j = 1 To 15
			.cells($i, $j).value = $i
		Next
	Next

	MsgBox($MB_SYSTEMMODAL, "", "Click 'ok' to clear the cells")
	.range("A1:O15").clear

EndWith

Sleep(2000)

$oMyExcel.activeworkbook.saved = 1 ; To prevent 'yes/no' questions from Excel

$oMyExcel.quit ; Get rid of him.

MsgBox($MB_SYSTEMMODAL, "ExcelTest", "Is Excel gone now ?")
; Nope, only invisible,
; but should be still in memory.

$oMyExcel = "" ; Only now Excel is removed from memory.

Exit
