#include <GDIPlus.au3>
#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $hGUI = GUICreate("GDI+ test", 800, 400)
	GUISetState(@SW_SHOW)

	If @OSBuild < 6000 Then MsgBox($MB_SYSTEMMODAL, "", "Antialiasing is automatically turned on for your operating system - no visible differences!")

	_GDIPlus_Startup()
	Local $hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI)
	_GDIPlus_GraphicsDrawString($hGraphics, "AutoIt rulez!", 0, 0, "Impact", 110)
	_GDIPlus_GraphicsSetTextRenderingHint($hGraphics, $GDIP_TEXTRENDERINGHINT_ANTIALIASGRIDFIT)
	_GDIPlus_GraphicsDrawString($hGraphics, "AutoIt rulez!", 0, 200, "Impact", 110)

	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				ExitLoop
		EndSwitch
	WEnd

	;cleanup resources
	_GDIPlus_GraphicsDispose($hGraphics)
	_GDIPlus_Shutdown()
	GUIDelete($hGUI)
EndFunc   ;==>Example
