; Open a browser with the form example, get reference to form, select
; each radio button byIndex, then deselect the last item leaving none selected.
; Note: You will likely need to scroll down on the page to see the changes

#include <IE.au3>

Local $oIE = _IE_Example("form")
Local $oForm = _IEFormGetObjByName($oIE, "ExampleForm")
For $i = 1 To 3
	_IEFormElementRadioSelect($oForm, 3, "radioExample", 1, "byIndex")
	Sleep(1000)
	_IEFormElementRadioSelect($oForm, 2, "radioExample", 1, "byIndex")
	Sleep(1000)
	_IEFormElementRadioSelect($oForm, 1, "radioExample", 1, "byIndex")
	Sleep(1000)
	_IEFormElementRadioSelect($oForm, 0, "radioExample", 1, "byIndex")
	Sleep(1000)
	_IEFormElementRadioSelect($oForm, 0, "radioExample", 0, "byIndex")
	Sleep(1000)
Next

_IEQuit($oIE)
