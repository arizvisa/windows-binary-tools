#include <WinAPIGdi.au3>

Local $iColor = 0xAADDFF

$iColor = _WinAPI_SwitchColor($iColor)
ConsoleWrite('0x' & Hex($iColor, 6) & @CRLF)
$iColor = _WinAPI_SwitchColor($iColor)
ConsoleWrite('0x' & Hex($iColor, 6) & @CRLF)
