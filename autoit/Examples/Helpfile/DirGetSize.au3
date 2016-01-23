#include <AutoItConstants.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $iSize = DirGetSize(@HomeDrive)
	MsgBox($MB_SYSTEMMODAL, "", "Size(MegaBytes): " & Round($iSize / 1024 / 1024))

	$iSize = DirGetSize(@WindowsDir, $DIR_NORECURSE)
	MsgBox($MB_SYSTEMMODAL, "", "Size(MegaBytes): " & Round($iSize / 1024 / 1024))

	Local $hTimer = TimerInit()

	Local $aSize = DirGetSize("\\10.0.0.1\h$", $DIR_EXTENDED) ; extended mode
	If Not @error Then
		Local $iDiff = Round(TimerDiff($hTimer) / 1000) ; time in seconds
		MsgBox($MB_SYSTEMMODAL, "", "Size(Bytes): " & $aSize[0] & @CRLF _
				 & "Files: " & $aSize[1] & @CRLF & "Dirs: " & $aSize[2] & @CRLF _
				 & "TimeDiff(Sec): " & $iDiff)
	EndIf
EndFunc   ;==>Example
