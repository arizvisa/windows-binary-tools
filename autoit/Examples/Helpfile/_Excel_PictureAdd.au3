#include <Excel.au3>
#include <MsgBoxConstants.au3>

; Create application object and open an example workbook
Local $oExcel = _Excel_Open()
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_PictureAdd Example", "Error creating the Excel application object." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
; Create new Workbook
Local $oWorkbook = _Excel_BookNew($oExcel)
If @error Then
	MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_PictureAdd Example", "Error creating workbook." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
	_Excel_Close($oExcel)
	Exit
EndIf

; *****************************************************************************
; Insert and resize the picture into a range of cells. Aspect ratio retained
; *****************************************************************************
Local $sPicture = @ScriptDir & "\Extras\_Excel.jpg"
_Excel_PictureAdd($oWorkbook, Default, $sPicture, "B2:D8")
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_PictureAdd Example 1", "Error inserting picture." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_PictureAdd Example 1", "Picture inserted/resized at 'B2:D8', aspect ratio retained.")

; *****************************************************************************
; Insert the picture without resizing.
; *****************************************************************************
_Excel_PictureAdd($oWorkbook, Default, $sPicture, "F8")
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_PictureAdd Example 2", "Error inserting picture." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_PictureAdd Example 2", "Picture inserted at 'F8' without resizing.")

; *****************************************************************************
; Insert the picture with a defined size/height.
; *****************************************************************************
_Excel_PictureAdd($oWorkbook, Default, $sPicture, "A8", Default, 300, 250)
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_PictureAdd Example 3", "Error inserting picture." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_PictureAdd Example 3", "Picture inserted at 'A8' with defined size/height, aspect ratio ignored")

; *****************************************************************************
; Insert the picture with a defined size/height.
; *****************************************************************************
_Excel_PictureAdd($oWorkbook, Default, $sPicture, 250, 300, 300, 250)
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_PictureAdd Example 4", "Error inserting picture." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_PictureAdd Example 4", "Picture inserted at position 250/300' with defined size/height, aspect ratio ignored")

; *****************************************************************************
; Insert the picture with a defined size/height.
; *****************************************************************************
_Excel_PictureAdd($oWorkbook, Default, $sPicture, "F2:H9", Default, Default, Default, False)
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_PictureAdd Example 5", "Error inserting picture." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_PictureAdd Example 5", "Picture inserted/resized at 'F2:H9', aspect ratio ignored.")
