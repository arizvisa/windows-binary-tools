; Open a browser with the basic example, check to see if the
; addressbar is visible, if it is turn it off, if it is not turn it on

#include <IE.au3>
#include <MsgBoxConstants.au3>

Local $oIE = _IE_Example("basic")
If _IEPropertyGet($oIE, "addressbar") Then
	MsgBox($MB_SYSTEMMODAL, "AddressBar Status", "AddressBar Visible, turning it off")
	_IEPropertySet($oIE, "addressbar", False)
Else
	MsgBox($MB_SYSTEMMODAL, "AddressBar Status", "AddressBar Invisible, turning it on")
	_IEPropertySet($oIE, "addressbar", True)
EndIf
