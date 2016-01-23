#include <GDIPlus.au3>
#include <GUIConstantsEx.au3>
#include <WinAPI.au3>
#include <WindowsConstants.au3>

Global $g_hGUI, $g_hHBITMAP, $g_hDC, $g_hDC_Backbuffer, $g_oDC_Obj, $g_hGfxCtxt, $g_hPen

Example()

Func Example()
	AutoItSetOption("GUIOnEventMode", 1)

	_GDIPlus_Startup() ;initialize GDI+
	Local Const $iWidth = 600, $iHeight = 600, $iBgColor = 0x202020 ;$iBGColor format RRGGBB

	$g_hGUI = GUICreate("GDI+ Example (" & @ScriptName & ")", $iWidth, $iHeight) ;create a test GUI
	GUISetBkColor($iBgColor, $g_hGUI) ;set GUI background color
	GUISetState(@SW_SHOW)

	;create a faster buffered graphics frame set for smoother gfx object movements
	Local $hBitmap = _GDIPlus_BitmapCreateFromScan0($iWidth, $iHeight) ;create an empty bitmap
	$g_hHBITMAP = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hBitmap) ;convert GDI+ bitmap to GDI bitmap
	_GDIPlus_BitmapDispose($hBitmap) ;delete GDI+ bitmap because not needed anymore

	$g_hDC = _WinAPI_GetDC($g_hGUI) ;get device context from GUI
	$g_hDC_Backbuffer = _WinAPI_CreateCompatibleDC($g_hDC) ;creates a memory device context compatible with the specified device
	$g_oDC_Obj = _WinAPI_SelectObject($g_hDC_Backbuffer, $g_hHBITMAP) ;selects an object into the specified device context
	$g_hGfxCtxt = _GDIPlus_GraphicsCreateFromHDC($g_hDC_Backbuffer) ;create a graphics object from a device context (DC)
	_GDIPlus_GraphicsSetSmoothingMode($g_hGfxCtxt, $GDIP_SMOOTHINGMODE_HIGHQUALITY) ;set smoothing mode (8 X 4 box filter)
	_GDIPlus_GraphicsSetPixelOffsetMode($g_hGfxCtxt, $GDIP_PIXELOFFSETMODE_HIGHQUALITY)

	$g_hPen = _GDIPlus_PenCreate() ;create a pen object

	GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit")

	Local Const $fDeg = ACos(-1) / 180 ;ACos(-1) is nearly pi
	Local $iX_Center = $iWidth / 2, $iY_Center = $iHeight / 2, $iXPos, $iYPos, $fAngle = 0, $iRound = 0
	Local Const $iDots = 7, $fAngelDist = 360 / $iDots, $iRadius = 250
	Local $aCoordinates[$iDots][2] ;create an array to save coordinates of the x/y coordinates
	Do
		_GDIPlus_GraphicsClear($g_hGfxCtxt, 0xFF000000 + $iBgColor) ;clear bitmap with given color (AARRGGBB format)
		For $i = 0 To $iDots - 1
			$iXPos = $iX_Center + Cos($fAngle * $fDeg) * $iRadius ;calculate x position
			$iYPos = $iY_Center + Sin($fAngle * $fDeg) * $iRadius ;calculate y position
			$aCoordinates[$i][0] = $iXPos
			$aCoordinates[$i][1] = $iYPos
			_GDIPlus_PenSetColor($g_hPen, 0xFFFFFF00) ;set pen color for inner lines
			_GDIPlus_PenSetWidth($g_hPen, 2) ;set pen size for outer lines
			_GDIPlus_GraphicsDrawLine($g_hGfxCtxt, $aCoordinates[$i][0], $aCoordinates[$i][1], _ ;draw inner lines
					$aCoordinates[Mod(($i + $iDots / 2), $iDots)][0], $aCoordinates[Mod(($i + $iDots / 2), $iDots)][1], $g_hPen) ;draw to opposite side
			_GDIPlus_PenSetColor($g_hPen, 0xFFFF8000) ;set pen color
			_GDIPlus_PenSetWidth($g_hPen, 3) ;set pen size
			;array of coordinates should be filled before first draw to screen
			If $i < $iDots - 1 Then _GDIPlus_GraphicsDrawLine($g_hGfxCtxt, $aCoordinates[$i][0], $aCoordinates[$i][1], $aCoordinates[$i + 1][0], $aCoordinates[$i + 1][1], $g_hPen) ;;draw outer lines
			$fAngle += $fAngelDist ;increase angle to next dot
		Next
		;draw last line to 1st line
		_GDIPlus_GraphicsDrawLine($g_hGfxCtxt, $aCoordinates[$i - 1][0], $aCoordinates[$i - 1][1], $aCoordinates[0][0], $aCoordinates[0][1], $g_hPen)

		If $iRound Then _WinAPI_BitBlt($g_hDC, 0, 0, $iWidth, $iHeight, $g_hDC_Backbuffer, 0, 0, $SRCCOPY) ;copy backbuffer to screen (GUI)
		$fAngle -= 0.5 ;decrease overall angle
		$iRound += 1
	Until Not Sleep(30) ;Sleep() always returns 1 and Not 1 is 0 correspond to False

	_Exit()
EndFunc   ;==>Example

Func _Exit() ;cleanup GDI+ resources
	_GDIPlus_PenDispose($g_hPen)
	_WinAPI_SelectObject($g_hDC_Backbuffer, $g_oDC_Obj)
	_GDIPlus_GraphicsDispose($g_hGfxCtxt)
	_WinAPI_DeleteObject($g_hHBITMAP)
	_WinAPI_ReleaseDC($g_hGUI, $g_hDC)
	GUIDelete($g_hGUI)
	Exit
EndFunc   ;==>_Exit
