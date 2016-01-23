#include <GUIConstantsEx.au3>

Example()

Func Example()
	GUICreate("My GUI Tab", 250, 150); will create a dialog box that when displayed is centered

	GUISetBkColor(0x00E0FFFF)
	GUISetFont(9, 300)

	Local $idTab = GUICtrlCreateTab(10, 10, 200, 100)

	GUICtrlCreateTabItem("tab0")
	GUICtrlCreateLabel("label0", 30, 80, 50, 20)
	GUICtrlCreateButton("OK0", 20, 50, 50, 20)
	GUICtrlCreateInput("default", 80, 50, 70, 20)

	GUICtrlCreateTabItem("tab----1")
	GUICtrlCreateLabel("label1", 30, 80, 50, 20)
	GUICtrlCreateCombo("", 20, 50, 60, 120)
	GUICtrlSetData(-1, "Trids|CyberSlug|Larry|Jon|Tylo|guinness", "Jon"); default Jon
	GUICtrlCreateButton("OK1", 80, 50, 50, 20)

	GUICtrlCreateTabItem("tab2")
	GUICtrlSetState(-1, $GUI_SHOW); will be display first
	GUICtrlCreateLabel("label2", 30, 80, 50, 20)
	GUICtrlCreateButton("OK2", 140, 50, 50)

	GUICtrlCreateTabItem(""); end tabitem definition

	GUICtrlCreateLabel("Click on tab and see the title", 20, 130, 250, 20)

	GUISetState(@SW_SHOW)

	Local $idMsg
	; Loop until the user exits.
	While 1
		$idMsg = GUIGetMsg()

		If $idMsg = $GUI_EVENT_CLOSE Then ExitLoop
		If $idMsg = $idTab Then
			; display the clicked tab
			WinSetTitle("My GUI Tab", "", "My GUI Tab" & GUICtrlRead($idTab))
		EndIf
	WEnd
EndFunc   ;==>Example
