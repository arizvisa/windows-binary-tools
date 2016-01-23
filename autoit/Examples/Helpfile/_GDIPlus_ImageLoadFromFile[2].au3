; PNG work around by Zedna

#include <GDIPlus.au3>
#include <GUIConstantsEx.au3>

#include <GUIConstantsEx.au3>
#include <WinAPI.au3>
#include <WindowsConstants.au3>
#include <WindowsConstants.au3>

; Create GUI
Global $g_hGUI = GUICreate("Show PNG", 250, 250)

; Load PNG image
_GDIPlus_Startup()
Global $g_hImage = _GDIPlus_ImageLoadFromFile("..\GUI\Torus.png")
Global $g_hGraphic = _GDIPlus_GraphicsCreateFromHWND($g_hGUI)

GUIRegisterMsg($WM_PAINT, "MY_WM_PAINT")
GUISetState(@SW_SHOW)

; Loop until the user exits.
While 1
	Switch GUIGetMsg()
		Case $GUI_EVENT_CLOSE
			ExitLoop

	EndSwitch
WEnd

; Clean up resources
_GDIPlus_GraphicsDispose($g_hGraphic)
_GDIPlus_ImageDispose($g_hImage)
_GDIPlus_Shutdown()

; Draw PNG image
Func MY_WM_PAINT($hWnd, $iMsg, $wParam, $lParam)
	#forceref $hWnd, $iMsg, $wParam, $lParam
	_WinAPI_RedrawWindow($g_hGUI, 0, 0, $RDW_UPDATENOW)
	_GDIPlus_GraphicsDrawImage($g_hGraphic, $g_hImage, 0, 0)
	_WinAPI_RedrawWindow($g_hGUI, 0, 0, $RDW_VALIDATE)
	Return $GUI_RUNDEFMSG
EndFunc   ;==>MY_WM_PAINT
