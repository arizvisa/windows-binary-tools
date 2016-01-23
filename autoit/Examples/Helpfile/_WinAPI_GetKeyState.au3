#include <WinAPISys.au3>
#include <WinAPIvkeysConstants.au3>

Local $aOnOff[2] = ['OFF', 'ON']

ConsoleWrite('NumLock: ' & $aOnOff[BitAND(_WinAPI_GetKeyState($VK_NUMLOCK), 1)] & @CRLF)
Sleep(1500)
Send('{NUMLOCK toggle}')
ConsoleWrite('NumLock: ' & $aOnOff[BitAND(_WinAPI_GetKeyState($VK_NUMLOCK), 1)] & @CRLF)
Sleep(1500)
Send('{NUMLOCK toggle}')
ConsoleWrite('NumLock: ' & $aOnOff[BitAND(_WinAPI_GetKeyState($VK_NUMLOCK), 1)] & @CRLF)
