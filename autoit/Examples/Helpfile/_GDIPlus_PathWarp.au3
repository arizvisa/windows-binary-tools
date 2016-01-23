#include <GDIPlus.au3>
#include <GUIConstantsEx.au3>

Example()

Func Example()
	Local $iW, $iH, $hGUI, $hGraphic, $hBrush, $hPath, $hFormat, $hFamily, $tLayout

	; Create GUI
	$iW = 600
	$iH = 300
	$hGUI = GUICreate("GDI+", $iW, $iH)
	GUISetState(@SW_SHOW)

	_GDIPlus_Startup()
	$hGraphic = _GDIPlus_GraphicsCreateFromHWND($hGUI) ;Create a graphics object from a window handle
	_GDIPlus_GraphicsSetSmoothingMode($hGraphic, $GDIP_SMOOTHINGMODE_HIGHQUALITY) ;Sets the graphics object rendering quality (antialiasing)
	_GDIPlus_GraphicsClear($hGraphic, 0xFF000000)

	$hBrush = _GDIPlus_BrushCreateSolid(0xFFFFFF00)

	$hPath = _GDIPlus_PathCreate() ;Create new path object

	$hFormat = _GDIPlus_StringFormatCreate()
	_GDIPlus_StringFormatSetAlign($hFormat, 1) ;Set alignment to center

	$hFamily = _GDIPlus_FontFamilyCreate("Arial Black") ;Create font family object
	$tLayout = _GDIPlus_RectFCreate(0, 0, $iW, $iH) ;Create string bounding rectangle
	_GDIPlus_PathAddString($hPath, "AutoIt rulez!" & @LF & "and so does" & @LF & "STAR WARS ;)", $tLayout, $hFamily, 0, 64, $hFormat) ;Add the outline of the string to the path

	Local $aPoints[5][2]
	$aPoints[0][0] = 4
	$aPoints[1][0] = $iW * 0.3
	$aPoints[1][1] = $iH * 0.3
	$aPoints[2][0] = $iW * 0.7
	$aPoints[2][1] = $iH * 0.3
	$aPoints[3][0] = 0
	$aPoints[3][1] = $iH
	$aPoints[4][0] = $iW
	$aPoints[4][1] = $iH

	_GDIPlus_PathWarp($hPath, 0, $aPoints, 0, 0, $iW, $iH) ;Warp path

	_GDIPlus_GraphicsFillPath($hGraphic, $hPath, $hBrush) ;Draw path to graphics handle (GUI)

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	; Clean up resources
	_GDIPlus_FontFamilyDispose($hFamily)
	_GDIPlus_StringFormatDispose($hFormat)
	_GDIPlus_PathDispose($hPath)
	_GDIPlus_BrushDispose($hBrush)
	_GDIPlus_GraphicsDispose($hGraphic)
	_GDIPlus_Shutdown()
EndFunc   ;==>Example
