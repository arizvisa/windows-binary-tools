#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	GUICreate("My GUI", 300, 200)

	Local $idFileMenu = GUICtrlCreateMenu("&File")
	GUICtrlCreateMenuItem("&Open", $idFileMenu)
	GUICtrlCreateMenuItem("&Save", $idFileMenu)
	GUICtrlCreateMenuItem("", $idFileMenu)

	Local $idOptionsMenu = GUICtrlCreateMenu("O&ptions", $idFileMenu)
	GUICtrlCreateMenuItem("View", $idOptionsMenu)
	GUICtrlCreateMenuItem("", $idOptionsMenu)
	GUICtrlCreateMenuItem("Tools", $idOptionsMenu)

	GUICtrlCreateMenuItem("", $idFileMenu)
	Local $idExitItem = GUICtrlCreateMenuItem("&Exit", $idFileMenu)

	Local $idHelpMenu = GUICtrlCreateMenu("&?")
	Local $idAboutItem = GUICtrlCreateMenuItem("&About", $idHelpMenu)

	Local $idEndBtn = GUICtrlCreateButton("End", 110, 140, 70, 20)

	SetMenuColor($idFileMenu, 0xEEBB99) ; BGR color value
	SetMenuColor($idOptionsMenu, 0x66BB99); BGR color value
	SetMenuColor($idHelpMenu, 0x99BBEE) ; BGR color value

	GUISetState(@SW_SHOW)

	Local $idMsg
	; Loop until the user exits.
	While 1
		$idMsg = GUIGetMsg()

		Switch $idMsg
			Case $idExitItem, $idEndBtn, $GUI_EVENT_CLOSE
				ExitLoop

			Case $idAboutItem
				MsgBox($MB_SYSTEMMODAL, "About...", "Colored menu sample")
		EndSwitch
	WEnd
EndFunc   ;==>Example

; Apply the color to the menu
Func SetMenuColor($nMenuID, $nColor)
	Local Const $MIM_APPLYTOSUBMENUS = 0x80000000
	Local Const $MIM_BACKGROUND = 0x00000002

	Local $hMenu = GUICtrlGetHandle($nMenuID)

	Local $hBrush = DllCall("gdi32.dll", "hwnd", "CreateSolidBrush", "int", $nColor)
	$hBrush = $hBrush[0]

	Local $tMenuInfo = DllStructCreate("dword;dword;dword;uint;dword;dword;ptr")
	DllStructSetData($tMenuInfo, 1, DllStructGetSize($tMenuInfo))
	DllStructSetData($tMenuInfo, 2, BitOR($MIM_APPLYTOSUBMENUS, $MIM_BACKGROUND))
	DllStructSetData($tMenuInfo, 5, $hBrush)

	DllCall("user32.dll", "int", "SetMenuInfo", "hwnd", $hMenu, "struct*", $tMenuInfo)

	; release Struct not really needed as it is a local
	$tMenuInfo = 0
EndFunc   ;==>SetMenuColor
