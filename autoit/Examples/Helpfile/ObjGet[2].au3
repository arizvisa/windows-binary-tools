; Example getting an Object using a file name
; ; An Excel file with filename Worksheet.xls must be created in the script directory
; in order for this example to work.
#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $sFileName = @ScriptDir & "\Worksheet.xls"

	If Not FileExists($sFileName) Then
		MsgBox($MB_SYSTEMMODAL, "", "Excel File Test" & @CRLF & "Can't run this test, because you didn't create the Excel file " & $sFileName)
		Return False
	EndIf

	Local $oExcelDoc = ObjGet($sFileName) ; Get an Excel Object from an existing filename

	If IsObj($oExcelDoc) Then

		; Tip: Uncomment these lines to make Excel visible (credit: DaleHohm)
		; $oExcelDoc.Windows(1).Visible = 1; Set the first worksheet in the workbook visible
		; $oExcelDoc.Application.Visible = 1; Set the application visible (without this Excel will exit)

		Local $sString = "" ; String for displaying purposes

		For $oProperty In $oExcelDoc.BuiltinDocumentProperties
			$sString &= $oProperty.Name & ":" & $oProperty.Value & @CRLF
		Next

		MsgBox($MB_SYSTEMMODAL, "", "Excel File Test:" & @CRLF & "The document properties of " & $sFileName & " are:" & @CRLF & @CRLF & $sString)

		$oExcelDoc.Close ; Close the Excel document

	Else
		MsgBox($MB_SYSTEMMODAL, "", "Excel File Test" & @CRLF & "Error: Could not open " & $sFileName & " as an Excel Object.")
	EndIf
EndFunc   ;==>Example
