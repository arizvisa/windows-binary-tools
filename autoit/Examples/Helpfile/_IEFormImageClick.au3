; Open a browser with the form example, click on the
; <input type=image> form element with matching alt text

#include <IE.au3>

Local $oIE = _IE_Example("form")
_IEFormImageClick($oIE, "AutoIt Homepage", "alt")
