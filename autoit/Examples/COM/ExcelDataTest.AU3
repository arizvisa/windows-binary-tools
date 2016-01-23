#include <MsgBoxConstants.au3>
#include <AutoItConstants.au3>

; ExcelDataTest.AU3
;
; Retrieves information from an Excel sheet
; Modifies the data
; Returns the modified data in back in the sheet

Local $sFileName = @ScriptDir & "\Worksheet.xls" ; Change this to the path/name of your Excel sheet
Local $sCellRange = "A1:E3" ; Change this to the range of cells you want to modify

If Not FileExists($sFileName) Then ; Just a check to be sure..
	MsgBox($MB_SYSTEMMODAL, "Excel Data Test", "Error: Can't find file " & $sFileName)
	Exit
EndIf

Local $oExcelDoc = ObjGet($sFileName) ; Get an Excel Object from an existing filename

If (Not @error) And IsObj($oExcelDoc) Then ; Check again If everything went well
	; NOTE: $oExcelDoc is a "Workbook Object", Not Excel itself!
	Local $oDocument = $oExcelDoc.Worksheets(1) ; We use the 'Default' worksheet

	Local $aArray = $oDocument.range($sCellRange).value ; Retrieve the cell values from given range

	; The data should now be in the 2-dimensional array: $aArray

	If IsArray($aArray) And UBound($aArray, $UBOUND_DIMENSIONS) > 0 Then ; Check If we retrieved any data

		MsgBox($MB_SYSTEMMODAL, "Excel Data Test", "Debugging information for retrieved cells:" & @CRLF & _
				"Number of dimensions: " & UBound($aArray, $UBOUND_DIMENSIONS) & @CRLF & _
				"Size of first dimension: " & UBound($aArray, $UBOUND_ROWS) & @CRLF & _
				"Size of second dimension: " & UBound($aArray, $UBOUND_COLUMNS))

		; The next lines are just for debugging purposes, it puts all cell values into
		; a string to display in a MsgBox.
		; Note: you can't use a FOR..IN loop for a multi-dimensional array!

		Local $s = ""
		For $x = 0 To UBound($aArray, $UBOUND_ROWS) - 1
			For $y = 0 To UBound($aArray, $UBOUND_COLUMNS) - 1
				$s = $s & "(" & $x & "," & $y & ")=" & $aArray[$x][$y] & @CRLF
			Next
		Next
		MsgBox($MB_SYSTEMMODAL, "Excel Data Test", "Debug information: Read Cell contents: " & @CRLF & $s)

		; Now we modify the data
		$aArray[0][0] = "This is cell A1"
		$aArray[1][1] = "This is cell B2"

		$oDocument.range($sCellRange).value = $aArray ; Write the data back in one shot

		$oExcelDoc.Windows(1).Visible = True ; Otherwise the worksheet window will be saved 'hidden'
		$oExcelDoc.Save ; Save the workbook

	Else
		MsgBox($MB_SYSTEMMODAL, "Excel Data Test", "Error: Could Not retrieve data from cell range: " & $sCellRange)
	EndIf

	$oExcelDoc.saved = 1 ; Prevent questions from excel to save the file
	$oExcelDoc.close ; Get rid of Excel.
Else
	MsgBox($MB_SYSTEMMODAL, "Excel Data Test", "Error: Could Not open " & $sFileName & " as an Excel Object.")
EndIf

$oExcelDoc = 0
