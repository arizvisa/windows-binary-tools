#include <GUIConstantsEx.au3>
#include <Misc.au3>
#include <WindowsConstants.au3>

Example()

Func Example()
	Local $hGUI, $idCOLORREF, $idBGR, $idRGB, $idMemo

	$hGUI = GUICreate("_ChooseColor() Example", 400, 300)
	$idMemo = GUICtrlCreateEdit("", 2, 55, 396, 200, BitOR($WS_VSCROLL, $WS_HSCROLL))
	GUICtrlSetFont($idMemo, 10, 400, 0, "Courier New")
	$idCOLORREF = GUICtrlCreateButton("COLORREF", 70, 10, 80, 40)
	$idBGR = GUICtrlCreateButton("BGR", 160, 10, 80, 40)
	$idRGB = GUICtrlCreateButton("RGB", 250, 10, 80, 40)
	GUISetState(@SW_SHOW)

	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				ExitLoop
			Case $idCOLORREF
				_ShowChoice($hGUI, $idMemo, 0, _ChooseColor(0, 255, 0, $hGUI), "COLORREF color of your choice: ")
			Case $idBGR
				_ShowChoice($hGUI, $idMemo, 1, _ChooseColor(2, 0x808000, 1, $hGUI), "BGR Hex color of your choice: ")
			Case $idRGB
				_ShowChoice($hGUI, $idMemo, 2, _ChooseColor(2, 0x0080C0, 2, $hGUI), "RGB Hex color of your choice: ")
		EndSwitch
	WEnd
EndFunc   ;==>Example

Func _ShowChoice($hGUI, $idMemo, $iType, $iChoose, $sMessage)
	Local $sCr
	If $iChoose <> -1 Then

		If $iType = 0 Then ; convert COLORREF to RGB for this example
			$sCr = Hex($iChoose, 6)
			GUISetBkColor('0x' & StringMid($sCr, 5, 2) & StringMid($sCr, 3, 2) & StringMid($sCr, 1, 2), $hGUI)
		Else
			GUISetBkColor($iChoose, $hGUI)
		EndIf

		GUICtrlSetData($idMemo, $sMessage & $iChoose & @CRLF, 1)

	Else
		GUICtrlSetData($idMemo, "User Canceled Selction" & @CRLF, 1)
	EndIf
EndFunc   ;==>_ShowChoice
