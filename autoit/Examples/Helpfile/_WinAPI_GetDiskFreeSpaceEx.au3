#include <WinAPIFiles.au3>

Local $aData = _WinAPI_GetDiskFreeSpaceEx(@HomeDrive)

ConsoleWrite('Total available free space on ' & @HomeDrive & ' => ' & $aData[0] & ' bytes' & @CRLF)
ConsoleWrite('Total available space on ' & @HomeDrive & ' => ' & $aData[1] & ' bytes' & @CRLF)
ConsoleWrite('Total free space on ' & @HomeDrive & ' => ' & $aData[2] & ' bytes' & @CRLF)
