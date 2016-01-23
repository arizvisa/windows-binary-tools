#include <WinAPIFiles.au3>

Local $aData = _WinAPI_GetVolumeInformation()

ConsoleWrite('Volume name: ' & $aData[0] & @CRLF)
ConsoleWrite('File system: ' & $aData[4] & @CRLF)
ConsoleWrite('Serial number: ' & $aData[1] & @CRLF)
ConsoleWrite('File name length: ' & $aData[2] & @CRLF)
ConsoleWrite('Flags: 0x' & Hex($aData[3]) & @CRLF)
