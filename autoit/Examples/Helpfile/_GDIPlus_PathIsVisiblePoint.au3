#include <GDIPlus.au3>
#include <GUIConstantsEx.au3>

Global $g_hGUI
Global $g_hGraphics, $g_hBmp_Buffer, $g_hGfx_Bufffer, $g_hBrush_NA, $g_hBrush_A, $g_hPen_NA, $g_hPen_A
Global $g_hPath, $g_hFormat, $g_hFamily

Example()

Func Example()
	AutoItSetOption("GUIOnEventMode", 1)

	Local Const $iW = 640, $iH = 240
	Local $tLayout

	$g_hGUI = GUICreate("GDI+", $iW, $iH)
	GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit")
	GUISetOnEvent($GUI_EVENT_MOUSEMOVE, "_MouseMove")
	GUISetState(@SW_SHOW)

	_GDIPlus_Startup()
	$g_hGraphics = _GDIPlus_GraphicsCreateFromHWND($g_hGUI)
	$g_hBmp_Buffer = _GDIPlus_BitmapCreateFromGraphics($iW, $iH, $g_hGraphics)
	$g_hGfx_Bufffer = _GDIPlus_ImageGetGraphicsContext($g_hBmp_Buffer)
	_GDIPlus_GraphicsSetSmoothingMode($g_hGfx_Bufffer, $GDIP_SMOOTHINGMODE_HIGHQUALITY)

	$g_hBrush_NA = _GDIPlus_BrushCreateSolid(0xFF000066)
	$g_hBrush_A = _GDIPlus_BrushCreateSolid(0xFF00FF00)
	$g_hPen_NA = _GDIPlus_PenCreate(0xFF666600, 4)
	$g_hPen_A = _GDIPlus_PenCreate(0xFF00FF00, 4)

	$g_hPath = _GDIPlus_PathCreate()

	$g_hFormat = _GDIPlus_StringFormatCreate()
	_GDIPlus_StringFormatSetAlign($g_hFormat, 1)
	$g_hFamily = _GDIPlus_FontFamilyCreate("Arial Black")
	$tLayout = _GDIPlus_RectFCreate(0, 0, $iW, $iH)
	_GDIPlus_PathAddString($g_hPath, "move mouse" & @LF & "over text", $tLayout, $g_hFamily, 0, 72, $g_hFormat)

	_MouseMove()

	While Sleep(10)
	WEnd
EndFunc   ;==>Example

Func _MouseMove()
	Local $sInfo = ""
	Local $aMouse = GUIGetCursorInfo()

	_GDIPlus_GraphicsClear($g_hGfx_Bufffer, 0xFF000000)
	_GDIPlus_GraphicsFillPath($g_hGfx_Bufffer, $g_hPath, $g_hBrush_NA)
	_GDIPlus_GraphicsDrawPath($g_hGfx_Bufffer, $g_hPath, $g_hPen_NA)
	Select
		Case _GDIPlus_PathIsOutlineVisiblePoint($g_hPath, $aMouse[0], $aMouse[1], $g_hPen_A, $g_hGfx_Bufffer)
			_GDIPlus_GraphicsDrawPath($g_hGfx_Bufffer, $g_hPath, $g_hPen_A)
			$sInfo = "mouse cursor touches path outline"
		Case _GDIPlus_PathIsVisiblePoint($g_hPath, $aMouse[0], $aMouse[1], $g_hGraphics)
			_GDIPlus_GraphicsFillPath($g_hGfx_Bufffer, $g_hPath, $g_hBrush_A)
			$sInfo = "mouse cursor in path fill area"
	EndSelect

	ToolTip($sInfo)
	_GDIPlus_GraphicsDrawImage($g_hGraphics, $g_hBmp_Buffer, 0, 0)
EndFunc   ;==>_MouseMove

Func _Exit()
	_GDIPlus_FontFamilyDispose($g_hFamily)
	_GDIPlus_StringFormatDispose($g_hFormat)
	_GDIPlus_PathDispose($g_hPath)
	_GDIPlus_BrushDispose($g_hBrush_NA)
	_GDIPlus_BrushDispose($g_hBrush_A)
	_GDIPlus_PenDispose($g_hPen_NA)
	_GDIPlus_PenDispose($g_hPen_A)

	_GDIPlus_GraphicsDispose($g_hGfx_Bufffer)
	_GDIPlus_BitmapDispose($g_hBmp_Buffer)
	_GDIPlus_GraphicsDispose($g_hGraphics)
	_GDIPlus_Shutdown()
	GUIDelete($g_hGUI)
	Exit
EndFunc   ;==>_Exit
