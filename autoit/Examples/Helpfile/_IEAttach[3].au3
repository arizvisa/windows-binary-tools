; Attach to a browser control embedded in another window

#include <IE.au3>

Local $oIE = _IEAttach("A Window Title", "embedded")
ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : $oIE = ' & $oIE & @CRLF & '>Error code: ' & @error & '    Extended code: 0x' & Hex(@extended) & @CRLF) ;### Debug Console
