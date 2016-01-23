#include <GUIConstantsEx.au3>
#include <GuiEdit.au3>
#include <GuiMenu.au3>
#include <WinAPI.au3>
#include <WindowsConstants.au3>

Global $g_idContextMenu, $g_idCommonMenuItem, $g_idFileMenuItem, $g_idExitMenuItem
Global $g_hGui, $g_idInput, $g_hProcOld

Example()

Func Example()
	Local $idInput2, $hProcNew, $idDummyMenu

	$g_hGui = GUICreate("Type or paste some stuff", 400, 200, -1, -1, $WS_THICKFRAME, -1)
	$g_idInput = GUICtrlCreateInput("", 20, 20, 360, 20)
	$idInput2 = GUICtrlCreateInput("", 20, 50, 360, 20)

	GUICtrlCreateLabel("abcd", 1, 1, 30, 18)
	GUICtrlSetCursor(-1, 9)

	$hProcNew = DllCallbackRegister("_MyWindowProc", "ptr", "hwnd;uint;long;ptr")
	$g_hProcOld = _WinAPI_SetWindowLong(GUICtrlGetHandle($g_idInput), $GWL_WNDPROC, DllCallbackGetPtr($hProcNew))
	_WinAPI_SetWindowLong(GUICtrlGetHandle($idInput2), $GWL_WNDPROC, DllCallbackGetPtr($hProcNew))
	;_WinAPI_SetWindowLong(GUICtrlGetHandle($g_idInput3), $GWL_WNDPROC, DllCallbackGetPtr($hProcNew)) and so on

	$idDummyMenu = GUICtrlCreateDummy()
	$g_idContextMenu = GUICtrlCreateContextMenu($idDummyMenu)
	$g_idCommonMenuItem = GUICtrlCreateMenuItem("Common", $g_idContextMenu)
	$g_idFileMenuItem = GUICtrlCreateMenuItem("File", $g_idContextMenu)
	GUICtrlCreateMenuItem("", $g_idContextMenu)
	$g_idExitMenuItem = GUICtrlCreateMenuItem("Exit", $g_idContextMenu)

	GUISetState(@SW_SHOW)
	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				ExitLoop
		EndSwitch
	WEnd
EndFunc   ;==>Example

Func do_clever_stuff_with_clipboard($hWnd)
	Local $sData
	$sData = ClipGet()
	If @error Then Return 0;clip data is not text or clip empty
	;do whatever
	$sData = StringUpper($sData)
	;set text
	GUICtrlSetData(_WinAPI_GetDlgCtrlID($hWnd), $sData);or _GUICtrlEdit_SetText($hWnd, $sData)
	Return 1
EndFunc   ;==>do_clever_stuff_with_clipboard

; Show a menu in a given GUI window which belongs to a given GUI ctrl
Func ShowMenu($hWnd, $idContext)
	Local $iSelected = _GUICtrlMenu_TrackPopupMenu(GUICtrlGetHandle($idContext), $hWnd, -1, -1, -1, -1, 2)
	Switch $iSelected
		Case $g_idCommonMenuItem
			ConsoleWrite("Common" & @CRLF)
		Case $g_idFileMenuItem
			ConsoleWrite("File" & @CRLF)
		Case $g_idExitMenuItem
			ConsoleWrite("Exit" & @CRLF)
	EndSwitch
EndFunc   ;==>ShowMenu

Func _MyWindowProc($hWnd, $iMsg, $wParam, $lParam)
	Switch $iMsg
		Case $WM_PASTE
			Return do_clever_stuff_with_clipboard($hWnd)
		Case $WM_CONTEXTMENU
			If $hWnd = GUICtrlGetHandle($g_idInput) Then
				ShowMenu($g_hGui, $g_idContextMenu)
				Return 0
			EndIf
		Case $WM_SETCURSOR
			GUICtrlSetCursor(_WinAPI_GetDlgCtrlID($hWnd), 5);;set Ibeam cursor
			Return 1;;and don't let default windowproc mess things up
	EndSwitch

	;pass the unhandled messages to default WindowProc
	Return _WinAPI_CallWindowProc($g_hProcOld, $hWnd, $iMsg, $wParam, $lParam)
EndFunc   ;==>_MyWindowProc
