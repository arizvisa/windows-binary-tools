#include <APISysConstants.au3>
#include <WinAPISys.au3>
#include <WinAPIvkeysConstants.au3>

ConsoleWrite('Virtual-key code: 0x' & Hex($VK_A) & @CRLF)
ConsoleWrite('Scan code: 0x' & Hex(_WinAPI_MapVirtualKey($VK_A, $MAPVK_VK_TO_VSC)) & @CRLF)
