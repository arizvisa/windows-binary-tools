#include <MsgBoxConstants.au3>

; COM Test file
;
; Excel file Automation Example

; An Excel file with filename Worksheet.xls must be created in the root directory
; of the C:\ drive in order for this example to work.

Local $sFileName = @ScriptDir & "\Worksheet.xls"

If Not FileExists($sFileName) Then
	MsgBox($MB_SYSTEMMODAL, "Excel File Test", "Can't run this test, because you didn't create the Excel file " & $sFileName)
	Exit
EndIf

Local $oExcelDoc = ObjGet($sFileName) ; Get an Excel Object from an existing filename

If IsObj($oExcelDoc) Then

	Local $sString = "" ; String for displaying purposes

	; Some document properties do not return a value, we will ignore those.
	Local $oEvent = ObjEvent("AutoIt.Error", "nothing") ; Equal to VBscript's On Error Resume Next

	For $oProperty In $oExcelDoc.BuiltinDocumentProperties
		; $sString = $sString &  $oProperty.Name & ":" & $oProperty.Value & @CRLF
		$sString = $sString & $oProperty.Name & ":" & @CRLF
	Next

	MsgBox($MB_SYSTEMMODAL, "Excel File Test", "The document properties of " & $sFileName & " are:" & @CRLF & @CRLF & $sString)

	$oExcelDoc.Close ; Close the Excel document

Else
	MsgBox($MB_SYSTEMMODAL, "Excel File Test", "Error: Could not open " & $sFileName & " as an Excel Object.")
EndIf
