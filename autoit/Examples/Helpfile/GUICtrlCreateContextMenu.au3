; right click on gui to bring up context Menu.
; right click on the "ok" button to bring up a controll specific context menu.

#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	GUICreate("My GUI Context Menu", 300, 200)

	Local $idContextmenu = GUICtrlCreateContextMenu()

	Local $idNewsubmenu = GUICtrlCreateMenu("new", $idContextmenu)
	Local $idNewsubmenuText = GUICtrlCreateMenuItem("text", $idNewsubmenu)

	Local $idButton = GUICtrlCreateButton("OK", 100, 100, 70, 20)
	Local $idButtoncontext = GUICtrlCreateContextMenu($idButton)
	Local $idMenuAbout = GUICtrlCreateMenuItem("About button", $idButtoncontext)

	Local $idMenuOpen = GUICtrlCreateMenuItem("Open", $idContextmenu)
	Local $idMenuSave = GUICtrlCreateMenuItem("Save", $idContextmenu)
	GUICtrlCreateMenuItem("", $idContextmenu) ; separator

	Local $idMenuInfo = GUICtrlCreateMenuItem("Info", $idContextmenu)

	GUISetState(@SW_SHOW)

	; Loop until the user exits.
	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				ExitLoop
			Case $idButton
				MsgBox($MB_SYSTEMMODAL, "Button Clicked", 'OK')
			Case $idMenuAbout
				MsgBox($MB_SYSTEMMODAL, "Menu Selected", 'About')
			Case $idMenuOpen
				MsgBox($MB_SYSTEMMODAL, "Menu Selected", 'Open')
			Case $idMenuSave
				MsgBox($MB_SYSTEMMODAL, "Menu Selected", 'Save')
			Case $idMenuInfo
				MsgBox($MB_SYSTEMMODAL, "Menu Selected", 'Info')
			Case $idNewsubmenuText
				MsgBox($MB_SYSTEMMODAL, "SubMenu Selected", 'Text')
		EndSwitch
	WEnd
	GUIDelete()
EndFunc   ;==>Example
