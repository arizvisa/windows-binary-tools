#include <MsgBoxConstants.au3>

Example()

Func Example()
	; Create a constant variable in Local scope of the shortcut filepath.
	Local Const $sFilePath = @DesktopDir & "\FileGetShortcutExample.lnk"

	; Create a shortcut on the desktop to explorer.exe and set the hotkey combination Ctrl+Alt+T or in AutoIt ^!t to the shortcut.
	FileCreateShortcut(@WindowsDir & "\explorer.exe", $sFilePath, @WindowsDir, "/e,c:\", _
			"Tooltip description of the shortcut.", @SystemDir & "\shell32.dll", "^!t", "15", @SW_SHOWMINNOACTIVE)

	; Retrieve details about the shortcut.
	Local $aDetails = FileGetShortcut($sFilePath)
	If Not @error Then
		MsgBox($MB_SYSTEMMODAL, "", "Path: " & $aDetails[0] & @CRLF & _
				"Working directory: " & $aDetails[1] & @CRLF & _
				"Arguments: " & $aDetails[2] & @CRLF & _
				"Description: " & $aDetails[3] & @CRLF & _
				"Icon filename: " & $aDetails[4] & @CRLF & _
				"Icon index: " & $aDetails[5] & @CRLF & _
				"Shortcut state: " & $aDetails[6] & @CRLF)
	EndIf

	; Delete the shortcut.
	FileDelete($sFilePath)
EndFunc   ;==>Example
