; Open a browser with the basic example page, insert HTML
; in and around the DIV tag named "IEAu3Data" and display Body HTML

#include <IE.au3>
#include <MsgBoxConstants.au3>

Local $oIE = _IE_Example("basic")
Local $oDiv = _IEGetObjById($oIE, "IEAu3Data")

_IEDocInsertHTML($oDiv, "<b>(HTML beforebegin)</b>", "beforebegin")
_IEDocInsertHTML($oDiv, "<i>(HTML afterbegin)</i>", "afterbegin")
_IEDocInsertHTML($oDiv, "<b>(HTML beforeend)</b>", "beforeend")
_IEDocInsertHTML($oDiv, "<i>(HTML afterend)</i>", "afterend")

MsgBox($MB_SYSTEMMODAL, "Body", _IEBodyReadHTML($oIE) & @CRLF)
