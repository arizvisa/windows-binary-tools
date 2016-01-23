#include <GUIConstantsEx.au3>
#include <GuiMenu.au3>
#include <WinAPI.au3>
#include <WindowsConstants.au3>

Global Enum $e_idOpen = 1000, $e_idSave, $e_idInfo

Example()

Func Example()
	; Create GUI
	GUICreate("Menu", 400, 300)
	GUISetState(@SW_SHOW)

	; Register message handlers
	GUIRegisterMsg($WM_COMMAND, "WM_COMMAND")
	GUIRegisterMsg($WM_CONTEXTMENU, "WM_CONTEXTMENU")

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
EndFunc   ;==>Example

; Handle WM_COMMAND messages
Func WM_COMMAND($hWnd, $iMsg, $wParam, $lParam)
	#forceref $hWnd, $iMsg, $lParam
	Switch $wParam
		Case $e_idOpen
			_WinAPI_ShowMsg("Open")
		Case $e_idSave
			_WinAPI_ShowMsg("Save")
		Case $e_idInfo
			_WinAPI_ShowMsg("Info")
	EndSwitch
EndFunc   ;==>WM_COMMAND

; Handle WM_CONTEXTMENU messages
Func WM_CONTEXTMENU($hWnd, $iMsg, $wParam, $lParam)
	#forceref $hWnd, $iMsg, $lParam
	Local $hMenu

	$hMenu = _GUICtrlMenu_CreatePopup()
	_GUICtrlMenu_InsertMenuItem($hMenu, 0, "Open", $e_idOpen)
	_GUICtrlMenu_InsertMenuItem($hMenu, 1, "Save", $e_idSave)
	_GUICtrlMenu_InsertMenuItem($hMenu, 3, "", 0)
	_GUICtrlMenu_InsertMenuItem($hMenu, 3, "Info", $e_idInfo)
	_GUICtrlMenu_TrackPopupMenu($hMenu, $wParam)
	_GUICtrlMenu_DestroyMenu($hMenu)
	Return True
EndFunc   ;==>WM_CONTEXTMENU
