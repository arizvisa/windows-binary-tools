; Create a browser window attached to a new instance of iexplore.exe
; This is often necessary in order to get a new session cookie context
; (session cookies are shared among all browser instances sharing the same iexplore.exe)

#include <IE.au3>

Opt("WinTitleMatchMode", 2)

ShellExecute("iexplore.exe", "about:blank")
WinWait("Windows Internet Explorer")

Local $oIE = _IEAttach("about:blank", "url")
_IELoadWait($oIE)
_IENavigate($oIE, "www.autoitscript.com")
