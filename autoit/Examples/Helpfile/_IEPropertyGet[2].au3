; Open a browser with the form example and get a reference to the form
; textarea element.  Get the coordinates and dimensions of the text area,
; outline its shape with the mouse and come to rest in the center

#include <IE.au3>

Local $oIE = _IE_Example("form")

Local $oForm = _IEFormGetObjByName($oIE, "ExampleForm")
Local $oTextArea = _IEFormElementGetObjByName($oForm, "textareaExample")

; Get coordinates and dimensions of the textarea
Local $iScreenX = _IEPropertyGet($oTextArea, "screenx")
Local $iScreenY = _IEPropertyGet($oTextArea, "screeny")
Local $iBrowserX = _IEPropertyGet($oTextArea, "browserx")
Local $iBrowserY = _IEPropertyGet($oTextArea, "browserY")
Local $iWidth = _IEPropertyGet($oTextArea, "width")
Local $iHeight = _IEPropertyGet($oTextArea, "height")

; Outline the textarea with the mouse, come to rest in the center
Local $iMousespeed = 50
MouseMove($iScreenX, $iScreenY, $iMousespeed)
MouseMove($iScreenX + $iWidth, $iScreenY, $iMousespeed)
MouseMove($iScreenX + $iWidth, $iScreenY + $iHeight, $iMousespeed)
MouseMove($iScreenX, $iScreenY + $iHeight, $iMousespeed)
MouseMove($iScreenX, $iScreenY, $iMousespeed)
MouseMove($iScreenX + $iWidth / 2, $iScreenY + $iHeight / 2, $iMousespeed)
