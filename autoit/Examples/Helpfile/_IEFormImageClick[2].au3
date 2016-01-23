; Open a browser with the form example, click on the <input type=image>
; form element with matching img source URL (sub-string)

#include <IE.au3>

Local $oIE = _IE_Example("form")
_IEFormImageClick($oIE, "autoit_6_240x100.jpg", "src")
