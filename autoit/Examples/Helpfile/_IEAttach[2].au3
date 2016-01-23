; Attach to a browser with "simple HTML page"
; in the text of it's top-level document

#include <IE.au3>

Local $oIE_basic = _IE_Example("basic")

Local $oIE = _IEAttach("simple HTML page", "text")
ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : $oIE = ' & $oIE & @CRLF & '>Error code: ' & @error & '    Extended code: 0x' & Hex(@extended) & @CRLF) ;### Debug Console
