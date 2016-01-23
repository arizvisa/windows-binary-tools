; Set the value of an INPUT TYPE=TEXT element using Send()

#include <IE.au3>

Local $oIE = _IE_Example("form")
Local $oForm = _IEFormGetObjByName($oIE, "ExampleForm")
Local $oInputFile = _IEFormElementGetObjByName($oForm, "textExample")

; Assign input focus to the field and then send the text string
_IEAction($oInputFile, "focus")

; Select existing content so it will be overwritten.
_IEAction($oInputFile, "selectall")

Send("This works")
