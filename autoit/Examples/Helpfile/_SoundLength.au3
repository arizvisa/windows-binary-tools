#include <MsgBoxConstants.au3>
#include <Sound.au3>

Local $aSound = _SoundOpen(@WindowsDir & "\media\tada.wav")
If @error = 2 Then
	MsgBox($MB_SYSTEMMODAL, "Error", "The file does not exist")
	Exit
ElseIf @extended <> 0 Then
	Local $iExtended = @extended ; Assign because @extended will be set after DllStructCreate().
	Local $tText = DllStructCreate("char[128]")
	DllCall("winmm.dll", "short", "mciGetErrorStringA", "str", $iExtended, "struct*", $tText, "int", 128)
	MsgBox($MB_SYSTEMMODAL, "Error", "The open failed." & @CRLF & "Error Number: " & $iExtended & @CRLF & "Error Description: " & DllStructGetData($tText, 1) & @CRLF & "Please Note: The sound may still play correctly.")
Else
	MsgBox($MB_SYSTEMMODAL, "Success", "The file opened successfully")
EndIf

MsgBox($MB_SYSTEMMODAL, "Sound Length", "The Sound has a length of:" & @CRLF & "hh:mm:ss - " & _
		_SoundLength($aSound, 1) & @CRLF & "Milliseconds - " & _SoundLength($aSound, 2))
