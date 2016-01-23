#include <WinAPIFiles.au3>

Local $aData, $iDrive = 0

While 1
	$aData = _WinAPI_GetDriveGeometryEx($iDrive)
	If @error Then
		ExitLoop
	EndIf
	If Not $iDrive Then
		ConsoleWrite('-------------------------------' & @CRLF)
	EndIf
	ConsoleWrite('Drive: ' & $iDrive & @CRLF)
	ConsoleWrite('Cylinders: ' & $aData[0] & @CRLF)
	ConsoleWrite('Tracks per Cylinder: ' & $aData[2] & @CRLF)
	ConsoleWrite('Sectors per Track: ' & $aData[3] & @CRLF)
	ConsoleWrite('Bytes per Sector: ' & $aData[4] & @CRLF)
	ConsoleWrite('Total Space: ' & $aData[5] & ' bytes' & @CRLF)
	ConsoleWrite('-------------------------------' & @CRLF)
	$iDrive += 1
WEnd
