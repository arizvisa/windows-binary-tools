; Open a browser with the form example, click on the
; <input type=image> form element with matching name

#include <IE.au3>

Local $oIE = _IE_Example("form")
_IEFormImageClick($oIE, "imageExample", "name")
