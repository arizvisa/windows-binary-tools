; Open a browser with the form example, get reference to form, select
; each radio button byValue, then deselect the last item leaving none selected.

#include <IE.au3>

Local $oIE = _IE_Example("form")
Local $oForm = _IEFormGetObjByName($oIE, "ExampleForm")
_IEAction($oForm, "focus")
For $i = 1 To 3
	_IEFormElementRadioSelect($oForm, "vehicleAirplane", "radioExample", 1, "byValue")
	Sleep(1000)
	_IEFormElementRadioSelect($oForm, "vehicleTrain", "radioExample", 1, "byValue")
	Sleep(1000)
	_IEFormElementRadioSelect($oForm, "vehicleBoat", "radioExample", 1, "byValue")
	Sleep(1000)
	_IEFormElementRadioSelect($oForm, "vehicleCar", "radioExample", 1, "byValue")
	Sleep(1000)
	_IEFormElementRadioSelect($oForm, "vehicleCar", "radioExample", 0, "byValue")
	Sleep(1000)
Next

_IEQuit($oIE)
