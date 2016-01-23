; Open a browser with the basic example page, insert text
; in and around the first Paragraph tag and display Body HTML

#include <IE.au3>
#include <MsgBoxConstants.au3>

Local $oIE = _IE_Example("basic")
Local $oP = _IETagNameGetCollection($oIE, "p", 0)

_IEDocInsertText($oP, "(Text beforebegin)", "beforebegin")
_IEDocInsertText($oP, "(Text afterbegin)", "afterbegin")
_IEDocInsertText($oP, "(Text beforeend)", "beforeend")
_IEDocInsertText($oP, "(Text afterend)", "afterend")

MsgBox($MB_SYSTEMMODAL, "Body", _IEBodyReadHTML($oIE) & @CRLF)
