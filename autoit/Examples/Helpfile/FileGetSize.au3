#include <MsgBoxConstants.au3>

Example()

Func Example()
	; Retrieve the file size (in bytes) of the AutoIt executable.
	Local $iFileSize = FileGetSize(@AutoItExe)

	; Display the file size and convert to a readable form.
	MsgBox($MB_SYSTEMMODAL, "", ByteSuffix($iFileSize))
EndFunc   ;==>Example

Func ByteSuffix($iBytes)
	Local $iIndex = 0, $aArray = [' bytes', ' KB', ' MB', ' GB', ' TB', ' PB', ' EB', ' ZB', ' YB']
	While $iBytes > 1023
		$iIndex += 1
		$iBytes /= 1024
	WEnd
	Return Round($iBytes) & $aArray[$iIndex]
EndFunc   ;==>ByteSuffix
