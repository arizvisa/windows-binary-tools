#include <Misc.au3>
#include <MsgBoxConstants.au3>

Global $g_sResult = ""

Check_VersionCompare("25.2.1", "5.2.1", 1)
Check_VersionCompare("5.12.0", "5.2.1", 1)
Check_VersionCompare("10.0.0.0", "12,0,0,0", -1)

Check_VersionCompare("1.2.1", "1.10", -1)
Check_VersionCompare("1.11.1b", "1.2", 1)
Check_VersionCompare("1.1b", "1.11c", -1)
Check_VersionCompare("1.11b", "1.1c", 1)
Check_VersionCompare("5.2.1", "5.2.1a", -1)
Check_VersionCompare("5.2.1", "5.2.1", 0)
Check_VersionCompare("5.2.1", "5.2.1.0", 0)
Check_VersionCompare("5.2.1a", "5.2.1.0", 1)
Check_VersionCompare("5.2.1a", "5.2.1.1", -1)
Check_VersionCompare("5.2.1b", "5.2.1.1a", -1)
Check_VersionCompare("5.2.1b", "5.2.1a", 1)
Check_VersionCompare("5.2.1a", "5.2.1a", 0)
Check_VersionCompare("5.2.1a", "5.2.1b", -1)

MsgBox($MB_SYSTEMMODAL, '_VersionCompare Results', $g_sResult)

Func Check_VersionCompare($sVersion1, $sVersion2, $iReturn)
	Local $iRet = _VersionCompare($sVersion1, $sVersion2)
	Local $iExtended = @extended
	$g_sResult &= '"' & $sVersion1 & '" to "' & $sVersion2 & @TAB & " return " & $iRet
	If $iRet <> $iReturn Then $g_sResult &= " INSTEAD of " & $iReturn
	$g_sResult &= @TAB & "@extended = " & $iExtended & @CRLF
EndFunc   ;==>Check_VersionCompare
