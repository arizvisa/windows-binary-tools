; Attach to a browser with "AutoIt" in its title, display the URL

#include <IE.au3>
#include <MsgBoxConstants.au3>

Local $oIE = _IECreate("www.autoitscript.com")
Local $oIE1 = _IECreate("www.google.com")

$oIE = _IEAttach("AutoIt")
MsgBox($MB_SYSTEMMODAL, "The URL", _IEPropertyGet($oIE, "locationurl"))

_IEQuit($oIE)
_IEQuit($oIE1)
