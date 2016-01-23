#include <GUIConstantsEx.au3>
#include <GuiReBar.au3>
#include <WinAPI.au3>
#include <WindowsConstants.au3>

Global $g_idMemo

Example()

Func Example()
	Local $hGUI, $idInput, $id_Get, $hReBar, $hInstance, $sText
	; Create GUI
	$hGUI = GUICreate("WinAPI", 400, 396)

	$idInput = GUICtrlCreateInput("4209", 0, 0, 100, 20)

	; create the rebar control
	$hReBar = _GUICtrlRebar_Create($hGUI, BitOR($CCS_TOP, $WS_BORDER, $RBS_VARHEIGHT, $RBS_AUTOSIZE, $RBS_BANDBORDERS))

	$g_idMemo = GUICtrlCreateEdit("", 2, 55, 396, 200, BitOR($WS_VSCROLL, $WS_HSCROLL))
	GUICtrlSetFont($g_idMemo, 10, 400, 0, "Courier New")

	;add band containing the  control
	_GUICtrlRebar_AddBand($hReBar, GUICtrlGetHandle($idInput), 120, 200, "String ID:")

	$id_Get = GUICtrlCreateButton("Get String", 0, 0, 90, 20)

	;add band containing the  control
	_GUICtrlRebar_AddBand($hReBar, GUICtrlGetHandle($id_Get), 120, 200)

	GUISetState(@SW_SHOW)

	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				Exit
			Case $id_Get
				GUICtrlSetData($g_idMemo, "")
				$hInstance = _WinAPI_LoadLibraryEx("shell32.dll", $LOAD_LIBRARY_AS_DATAFILE)
				If $hInstance Then
					$sText = _WinAPI_LoadString($hInstance, GUICtrlRead($idInput))
					If Not @error Then
						MemoWrite('Got the String (chars: ' & @extended & '): ' & @CRLF & $sText)
					Else
						MemoWrite("Last Error Message: " & @CRLF & _WinAPI_GetLastErrorMessage())
					EndIf
					MemoWrite(@CRLF & "Success Freeing? " & _WinAPI_FreeLibrary($hInstance))
				EndIf
		EndSwitch
	WEnd
EndFunc   ;==>Example

; Write message to memo
Func MemoWrite($sMessage = "")
	GUICtrlSetData($g_idMemo, $sMessage & @CRLF, 1)
EndFunc   ;==>MemoWrite
