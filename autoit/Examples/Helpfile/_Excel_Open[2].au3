#include <Excel.au3>
#include <MsgBoxConstants.au3>

; *****************************************************************************
; Force the creation of a new Excel application and display alerts
; *****************************************************************************
_Excel_Open(Default, Default, Default, Default, True)
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_Open Example 2", "Error creating a new Excel application object." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
Local $aProcesses = ProcessList("Excel.exe")
If $aProcesses[0][0] = 1 Then
	MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_Open Example 2", "Excel Application has been opened successfully." & @CRLF & @CRLF & $aProcesses[0][0] & " Excel instance is running.")
Else
	MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_Open Example 2", "Excel Application has been opened successfully." & @CRLF & @CRLF & $aProcesses[0][0] & " Excel instances are running.")
EndIf
