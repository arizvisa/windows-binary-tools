#include <MsgBoxConstants.au3>

; COM Test file
;
; Excel Automation Example
;
; Using direct assigments of 2-dimensional array's

Local $oMyExcel = ObjCreate("Excel.Application") ; Create an Excel Object

If @error Then
	MsgBox($MB_SYSTEMMODAL, "", "Error creating Excel object. Error code: " & @error)
	Exit
EndIf

If Not IsObj($oMyExcel) Then
	MsgBox($MB_SYSTEMMODAL, "ExcelTest", "I'm sorry, but creation of an Excel object failed.")
	Exit
EndIf

$oMyExcel.Visible = 1 ; Let the guy show himself

$oMyExcel.workbooks.add ; Add a new workbook

; Example: Fast Fill some cells

MsgBox($MB_SYSTEMMODAL, "", "Click 'ok' To fastfill some cells")

Local $aArray[16][16]

For $i = 0 To 15
	For $j = 0 To 15
		$aArray[$i][$j] = Chr($i + 65) & ($j + 1)
	Next
Next

; Set all values in one shot!
$oMyExcel.activesheet.range("A1:O16").value = $aArray

MsgBox($MB_SYSTEMMODAL, "", "Click 'ok' To clear the cells")

$oMyExcel.activesheet.range("A1:O16").clear

Sleep(2000)

$oMyExcel.activeworkbook.saved = 1 ; To prevent 'yes/no' questions from Excel

$oMyExcel.quit ; Get rid of him.

MsgBox($MB_SYSTEMMODAL, "ExcelTest", "Is Excel gone now ?")
; Nope, only invisible,
; but should be still in memory.

$oMyExcel = 0 ; Loose this object.
; Object will also be automatically discarded when you Exit the script

Exit
