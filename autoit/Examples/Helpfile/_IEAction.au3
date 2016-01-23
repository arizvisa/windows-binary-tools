; Open a browser with the "form" example, get a reference
; to the submit button by name and "click" it. This technique
; of submitting forms is useful because many forms rely on JavaScript
; code and "onClick" events on their submit button making _IEFormSubmit()
; not perform as expected

#include <IE.au3>

Local $oIE = _IE_Example("form")
Local $oSubmit = _IEGetObjByName($oIE, "submitExample")
_IEAction($oSubmit, "click")
_IELoadWait($oIE)
