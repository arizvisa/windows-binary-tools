#include <GUIConstantsEx.au3>
#include <GuiToolbar.au3>

Example()

Func Example()
	Local $hGUI, $hToolbar
	Local Enum $e_idRed = 1000, $e_idGreen, $e_idBlue
	Local $sWow64 = ""
	If @AutoItX64 Then $sWow64 = "\Wow6432Node"
	Local $sPath = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE" & $sWow64 & "\AutoIt v3\AutoIt", "InstallDir") & "\Examples\GUI\Advanced\Images"

	; Create GUI
	$hGUI = GUICreate("Toolbar", 400, 300)
	$hToolbar = _GUICtrlToolbar_Create($hGUI)
	GUISetState(@SW_SHOW)

	; Add bitmaps
	_GUICtrlToolbar_LoadBitmap($hToolbar, $sPath & "\red.bmp")
	_GUICtrlToolbar_LoadBitmap($hToolbar, $sPath & "\green.bmp")
	_GUICtrlToolbar_LoadBitmap($hToolbar, $sPath & "\blue.bmp")

	; Add buttons
	_GUICtrlToolbar_AddButton($hToolbar, $e_idRed, 0)
	_GUICtrlToolbar_AddButton($hToolbar, $e_idGreen, 1)
	_GUICtrlToolbar_AddButton($hToolbar, $e_idBlue, 2)

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
EndFunc   ;==>Example
