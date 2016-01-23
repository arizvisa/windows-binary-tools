#include <WinAPISys.au3>

Local $sText
Local $iData = _WinAPI_GetKeyboardType(0)
Switch $iData
	Case 1
		$sText = 'IBM PC/XT or compatible (83-key) keyboard'
	Case 2
		$sText = 'Olivetti "ICO" (102-key) keyboard'
	Case 3
		$sText = 'IBM PC/AT (84-key) or similar keyboard'
	Case 4
		$sText = 'IBM enhanced (101- or 102-key) keyboard'
	Case 5
		$sText = 'Nokia 1050 and similar keyboards'
	Case 6
		$sText = 'Nokia 9140 and similar keyboards'
	Case 7
		$sText = 'Japanese keyboard'
EndSwitch

ConsoleWrite('Type   : ' & $sText & @CRLF)
ConsoleWrite('Subtype: ' & _WinAPI_GetKeyboardType(1) & @CRLF)
ConsoleWrite('F-keys : ' & _WinAPI_GetKeyboardType(2) & @CRLF)
