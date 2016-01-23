#include <GDIPlus.au3>
#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $hGUI = GUICreate("GDI+", 200, 180, -1, 50)
	GUISetState(@SW_SHOW)

	_GDIPlus_Startup()
	Local $hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI)
	_GDIPlus_GraphicsSetSmoothingMode($hGraphics, $GDIP_SMOOTHINGMODE_HIGHQUALITY)
	_GDIPlus_GraphicsClear($hGraphics, 0xFF000000)

	Local $hPath = _GDIPlus_PathCreate()
	_GDIPlus_PathAddEllipse($hPath, 10, 10, 180, 160)

	Local $hBrush = _GDIPlus_PathBrushCreateFromPath($hPath)
	_GDIPlus_PathBrushSetCenterColor($hBrush, 0xFFFFFF00)
	_GDIPlus_PathBrushSetCenterPoint($hBrush, 90, 80)
	_GDIPlus_PathBrushSetSurroundColor($hBrush, 0xFF0000FF)

	_GDIPlus_PathBrushSetGammaCorrection($hBrush, True)

	Local $aRect = _GDIPlus_PathBrushGetRect($hBrush)
	_GDIPlus_GraphicsFillRect($hGraphics, $aRect[0], $aRect[1], $aRect[2], $aRect[3], $hBrush)

	Local $aCoord = _GDIPlus_PathBrushGetCenterPoint($hBrush)
	MsgBox($MB_SYSTEMMODAL, "", "Center point X coordinate: " & $aCoord[0] & @CRLF & "Center point Y coordinate: " & $aCoord[1])

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	; Clean up resources
	_GDIPlus_BrushDispose($hBrush)
	_GDIPlus_PathDispose($hPath)
	_GDIPlus_GraphicsDispose($hGraphics)
	_GDIPlus_Shutdown()
EndFunc   ;==>Example
