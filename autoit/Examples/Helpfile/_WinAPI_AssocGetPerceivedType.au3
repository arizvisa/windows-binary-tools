#include <WinAPIReg.au3>

Local $sExt = '.wav'
Local $aData = _WinAPI_AssocGetPerceivedType($sExt)

If IsArray($aData) Then
	ConsoleWrite('(' & $sExt & ')' & @CRLF)
	ConsoleWrite('--------------------' & @CRLF)
	ConsoleWrite('Type:   ' & $aData[0] & @CRLF)
	ConsoleWrite('Source: ' & $aData[1] & @CRLF)
	ConsoleWrite('String: ' & $aData[2] & @CRLF)
EndIf
