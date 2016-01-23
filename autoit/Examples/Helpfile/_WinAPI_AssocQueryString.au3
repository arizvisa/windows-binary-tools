#include <APIRegConstants.au3>
#include <WinAPIReg.au3>

Local $sExt = '.au3'

ConsoleWrite('(' & $sExt & ')' & @CRLF)
ConsoleWrite('--------------------' & @CRLF)
ConsoleWrite('Type: ' & _WinAPI_AssocQueryString($sExt, $ASSOCSTR_FRIENDLYDOCNAME) & @CRLF)
ConsoleWrite('Command: ' & _WinAPI_AssocQueryString($sExt, $ASSOCSTR_COMMAND) & @CRLF)
ConsoleWrite('Executable: ' & _WinAPI_AssocQueryString($sExt, $ASSOCSTR_EXECUTABLE) & @CRLF)
ConsoleWrite('Icon: ' & _WinAPI_AssocQueryString($sExt, $ASSOCSTR_DEFAULTICON) & @CRLF)
