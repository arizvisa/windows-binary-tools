; Attach to the 3rd browser control embedded in another window
; Use the advanced window title syntax to use the 2nd window
; with the string 'ICQ' in the title

#include <IE.au3>

Local $oIE = _IEAttach("[REGEXPTITLE:ICQ; INSTANCE:2]", "embedded", 3)
