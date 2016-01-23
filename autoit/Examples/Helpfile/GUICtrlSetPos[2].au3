#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $iOldOpt = Opt("GUICoordMode", 1)

	Local $hGUI = GUICreate("My GUI icon Race", 350, 74, -1, -1)
	GUICtrlCreateLabel("", 331, 0, 1, 74, 5)
	Local $idIcon1 = GUICtrlCreateIcon(@ScriptDir & '\Extras\dinosaur.ani', -1, 0, 0, 32, 32)
	Local $idIcon2 = GUICtrlCreateIcon(@ScriptDir & '\Extras\horse.ani', -1, 0, 40, 32, 32)

	GUISetState(@SW_SHOW)

	Local $a = 0, $b = 0
	While ($a < 300) And ($b < 300)
		$a += Random(0, 1, 1)
		$b += Random(0, 1, 1)
		GUICtrlSetPos($idIcon1, $a, 0)
		GUICtrlSetPos($idIcon2, $b, 40)
		Sleep(10)
	WEnd
	Opt("GUICoordMode", $iOldOpt)
	If $a > $b Then
		MsgBox($MB_SYSTEMMODAL, 'Race results', 'The dinosaur won', 0, $hGUI)
	Else
		MsgBox($MB_SYSTEMMODAL, 'Race results', 'The horse won', 0, $hGUI)
	EndIf
EndFunc   ;==>Example
