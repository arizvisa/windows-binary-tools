#include <Date.au3>
#include <WinAPILocale.au3>
#include <WinAPIProc.au3>

Local $aFT, $tFT, $tST, $iID = ProcessExists('SciTE.exe')

If $iID Then
	$aFT = _WinAPI_GetProcessTimes($iID)
	$tFT = _Date_Time_FileTimeToLocalFileTime($aFT[0])
	$tST = _Date_Time_FileTimeToSystemTime($tFT)
	ConsoleWrite('!SciTE was run at: ' & _WinAPI_GetTimeFormat(0, $tST) & @CRLF)
EndIf
