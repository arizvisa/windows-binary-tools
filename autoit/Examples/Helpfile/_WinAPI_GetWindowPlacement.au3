#include <MsgBoxConstants.au3>
#include <WinAPI.au3>

Local $hWnd, $iRET, $sMsg, $tRET

; Create an instance of notepad to play with
Run("notepad.exe")
$hWnd = WinWait("[CLASS:Notepad]")
WinMove($hWnd, "", 256, 256, 400, 400)
Sleep(1000)

; Minimize and then check the placement values returned by _WinAPI_GetWindowPlacement()
WinSetState($hWnd, "", @SW_MINIMIZE)
$tRET = _WinAPI_GetWindowPlacement($hWnd)
If @error = 0 Then
	$sMsg = "$stWindowPlacement:" & @CRLF & @CRLF
	$sMsg &= @TAB & "length = " & DllStructGetData($tRET, "length") & @CRLF
	$sMsg &= @TAB & "flags = " & DllStructGetData($tRET, "flags") & @CRLF
	$sMsg &= @TAB & "showCmd = " & DllStructGetData($tRET, "showCmd") & @CRLF & @CRLF
	$sMsg &= "ptMinPosition:" & @CRLF
	$sMsg &= @TAB & "MinX = " & DllStructGetData($tRET, "ptMinPosition", 1) & @CRLF
	$sMsg &= @TAB & "MinY = " & DllStructGetData($tRET, "ptMinPosition", 2) & @CRLF & @CRLF
	$sMsg &= "ptMaxPosition:" & @CRLF
	$sMsg &= @TAB & "MaxX = " & DllStructGetData($tRET, "ptMaxPosition", 1) & @CRLF
	$sMsg &= @TAB & "MaxY = " & DllStructGetData($tRET, "ptMaxPosition", 2) & @CRLF & @CRLF
	$sMsg &= "rcNormalPosition:" & @CRLF
	$sMsg &= @TAB & "left = " & DllStructGetData($tRET, "rcNormalPosition", 1) & @CRLF
	$sMsg &= @TAB & "top = " & DllStructGetData($tRET, "rcNormalPosition", 2) & @CRLF
	$sMsg &= @TAB & "right = " & DllStructGetData($tRET, "rcNormalPosition", 3) & @CRLF
	$sMsg &= @TAB & "bottom = " & DllStructGetData($tRET, "rcNormalPosition", 4)
	MsgBox($MB_SYSTEMMODAL, "Success", $sMsg)

	; Change the normalized rectangle with _WinAPI_SetWindowPlacement() and then restore
	DllStructSetData($tRET, "rcNormalPosition", 128, 1); left
	DllStructSetData($tRET, "rcNormalPosition", 128, 2); top
	DllStructSetData($tRET, "rcNormalPosition", @DesktopWidth - 128, 3); right
	DllStructSetData($tRET, "rcNormalPosition", @DesktopHeight - 128, 4); bottom
	$iRET = _WinAPI_SetWindowPlacement($hWnd, $tRET)
	If @error = 0 Then
		WinSetState($hWnd, "", @SW_RESTORE)
		ControlSetText($hWnd, "", "Edit1", "_WinAPI_SetWindowPlacement() succeeded!")
	Else
		MsgBox($MB_SYSTEMMODAL, "Error", "_WinAPI_SetWindowPlacement() failed!" & @CRLF & _
				"$iRET = " & $iRET & @CRLF & _
				"@error = " & @error & @CRLF & _
				"@extended = " & @extended)
	EndIf
Else
	MsgBox($MB_SYSTEMMODAL, "Error", "_WinAPI_GetWindowPlacement() failed!" & @CRLF & _
			"$tRET = " & $tRET & @CRLF & _
			"@error = " & @error & @CRLF & _
			"@extended = " & @extended)
EndIf
