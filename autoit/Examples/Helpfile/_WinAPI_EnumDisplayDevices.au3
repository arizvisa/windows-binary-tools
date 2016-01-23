#include <MsgBoxConstants.au3>
#include <WinAPI.au3>

Example()

Func Example()
	Local $aDevice, $i = 0, $sText
	While 1
		$aDevice = _WinAPI_EnumDisplayDevices("", $i)
		If @error Or Not $aDevice[0] Then ExitLoop
		$sText = "Successful? " & $aDevice[0] & @CRLF
		$sText &= "Device (Adapter or Monitor): " & $aDevice[1] & @CRLF
		$sText &= "Description (Adapter or Monitor): " & $aDevice[2] & @CRLF
		$sText &= "Device State Flag: " & $aDevice[3] & @CRLF
		If BitAND($aDevice[3], 32) Then $sText &= @TAB & "- The device has more display modes than its output devices support" & @CRLF

		If BitAND($aDevice[3], 16) Then $sText &= @TAB & "- The device is removable; it cannot be the primary display" & @CRLF
		If BitAND($aDevice[3], 8) Then $sText &= @TAB & "- The device is VGA compatible" & @CRLF
		If BitAND($aDevice[3], 4) Then $sText &= @TAB & "- Represents a pseudo device used to mirror application drawing for remoting" & @CRLF
		If BitAND($aDevice[3], 2) Then $sText &= @TAB & "- The primary desktop is on the device" & @CRLF
		If BitAND($aDevice[3], 1) Then $sText &= @TAB & "- The device is part of the desktop" & @CRLF

		$sText &= "Plug and Play identifier string: " & $aDevice[4] & @CRLF
		MsgBox($MB_SYSTEMMODAL, "", $sText)
		$i += 1
	WEnd
EndFunc   ;==>Example
