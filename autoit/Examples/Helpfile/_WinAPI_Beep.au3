#include <MsgBoxConstants.au3>
#include <WinAPI.au3>

Example()

Func Example()
	Local $iFreqStart = 100
	Local $iFreqEnd = 250

	MsgBox($MB_SYSTEMMODAL, "_WinAPI_Beep Example", "Ascending")

	For $iFreq = $iFreqStart To $iFreqEnd
		_WinAPI_Beep($iFreq, 100)
		ToolTip("Frequency = " & $iFreq)
	Next

	MsgBox($MB_SYSTEMMODAL, "_WinAPI_Beep Example", "Descending")

	For $iFreq = $iFreqEnd To $iFreqStart Step -1
		_WinAPI_Beep($iFreq, 100)
		ToolTip("Frequency = " & $iFreq)
	Next
EndFunc   ;==>Example
