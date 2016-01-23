#include <Excel.au3>
#include <MsgBoxConstants.au3>

; Create application object
Local $oExcel1 = ObjCreate("Excel.Application")
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_Close Example", "Error creating the first Excel application object." & @CRLF & "@error = " & @error & ", @extended = " & @extended)

; Open Excel application (force new instance)
Local $oExcel2 = _Excel_Open(Default, Default, Default, Default, True)
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_Close Example", "Error creating the second Excel application object." & @CRLF & "@error = " & @error & ", @extended = " & @extended)

; *****************************************************************************
; Close the Excel instance which was not opened by _Excel_Open
; (will still be running because it was not opened by _Excel_Open)
; *****************************************************************************
_Excel_Close($oExcel1)
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_Close Example 1", "Error closing the Excel application." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
Sleep(2000)
Local $aProcesses = ProcessList("Excel.exe")
MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_Close Example 1", "Function ended successfully." & @CRLF & @CRLF & $aProcesses[0][0] & " Excel instance(s) still running.")

; *****************************************************************************
; Close the Excel instance opened by _Excel_Open
; *****************************************************************************
_Excel_Close($oExcel2)
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_Close Example 2", "Error closing the Excel application." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
Sleep(2000)
$aProcesses = ProcessList("Excel.exe")
MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_Close Example 2", "Function ended successfully." & @CRLF & @CRLF & $aProcesses[0][0] & " Excel instance(s) still running.")

; *****************************************************************************
; Force the Excel instance not opened by _Excel_Open
; without saving open workbooks
; *****************************************************************************
_Excel_Close($oExcel1, Default, True)
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_Close Example 3", "Error closing the Excel application." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
Sleep(2000)
$aProcesses = ProcessList("Excel.exe")
MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_Close Example 3", "Function ended successfully." & @CRLF & @CRLF & $aProcesses[0][0] & " Excel instance(s) still running.")
