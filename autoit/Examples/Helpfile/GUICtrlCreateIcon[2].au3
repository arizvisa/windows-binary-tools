Example()

Func Example()
	Local $iOldOpt = Opt("GUICoordMode", 1)

	GUICreate("My GUI icon Race", 350, 74, -1, -1)
	GUICtrlCreateLabel("", 331, 0, 1, 74, 5)
	Local $id1 = GUICtrlCreateIcon(@ScriptDir & '\Extras\dinosaur.ani', -1, 0, 0, 32, 32)
	Local $id2 = GUICtrlCreateIcon(@ScriptDir & '\Extras\horse.ani', -1, 0, 40, 32, 32)

	GUISetState(@SW_SHOW)

	Local $a = 0
	Local $b = 0
	While ($a < 300) And ($b < 300)
		$a = $a + Int(Random(0, 1) + 0.5)
		$b = $b + Int(Random(0, 1) + 0.5)
		GUICtrlSetPos($id1, $a, 0)
		GUICtrlSetPos($id2, $b, 40)
		Sleep(10)
	WEnd
	Sleep(3000)
	Opt("GUICoordMode", $iOldOpt)
EndFunc   ;==>Example
