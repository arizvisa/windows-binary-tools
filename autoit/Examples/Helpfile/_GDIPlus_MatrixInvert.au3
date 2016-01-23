#include <GDIPlus.au3>
#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	AutoItSetOption("MouseCoordMode", $OPT_COORDSCLIENT)

	; X64 running support
	Local $sWow64 = ""
	If @AutoItX64 Then $sWow64 = "\Wow6432Node"

	;get AutoIt install dir
	Local $sRegPath = "HKLM\SOFTWARE" & $sWow64 & "\AutoIt v3\AutoIt"

	Local $sFile = RegRead($sRegPath, "InstallDir") & "\Examples\GUI\logo4.gif"
	If Not FileExists($sFile) Then
		MsgBox(BitOR($MB_SYSTEMMODAL, $MB_ICONHAND), "", $sFile & " not found!", 30)
		Return 0
	EndIf

	Local $hGUI = GUICreate("GDI+ move mouse over transformed image and watch green cursor", 800, 400)
	GUISetState(@SW_SHOW)

	_GDIPlus_Startup()
	Local $hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI) ;Create a graphics object from a window handle
	Local $hBmp_Buffer = _GDIPlus_BitmapCreateFromGraphics(800, 400, $hGraphics)
	Local $hGfx_Buffer = _GDIPlus_ImageGetGraphicsContext($hBmp_Buffer)
	_GDIPlus_GraphicsClear($hGfx_Buffer, 0xFF000000)

	Local $hImage = _GDIPlus_ImageLoadFromFile($sFile)

	_GDIPlus_GraphicsDrawImage($hGfx_Buffer, $hImage, 550, 100)

	Local $hMatrix = _GDIPlus_MatrixCreate()
	_GDIPlus_MatrixScale($hMatrix, 2, 2)
	_GDIPlus_MatrixRotate($hMatrix, 20)
	_GDIPlus_MatrixTranslate($hMatrix, 50, 20)
	_GDIPlus_GraphicsSetTransform($hGfx_Buffer, $hMatrix)

	_GDIPlus_GraphicsDrawImage($hGfx_Buffer, $hImage, 0, 0)

	_GDIPlus_MatrixInvert($hMatrix) ;Invert matrix

	Local $hPen = _GDIPlus_PenCreate(0xFF00FF00, 2)
	Local $aMouse[2][2] = [[1]]
	Local $hTimer = TimerInit()
	; Loop until the user exits.
	Do
		If TimerDiff($hTimer) > 100 Then
			$aMouse[1][0] = MouseGetPos(0)
			$aMouse[1][1] = MouseGetPos(1)
			_GDIPlus_MatrixTransformPoints($hMatrix, $aMouse) ;Transform Mouseposition by inverted matrix back to original image

			_GDIPlus_GraphicsDrawImage($hGraphics, $hBmp_Buffer, 0, 0)
			_GDIPlus_GraphicsDrawLine($hGraphics, 550 + $aMouse[1][0] - 5, 100 + $aMouse[1][1], 550 + $aMouse[1][0] + 5, 100 + $aMouse[1][1], $hPen)
			_GDIPlus_GraphicsDrawLine($hGraphics, 550 + $aMouse[1][0], 100 + $aMouse[1][1] - 5, 550 + $aMouse[1][0], 100 + $aMouse[1][1] + 5, $hPen)

			$hTimer = TimerInit()
		EndIf
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	; Clean up resources
	_GDIPlus_PenDispose($hPen)
	_GDIPlus_MatrixDispose($hMatrix)
	_GDIPlus_ImageDispose($hImage)
	_GDIPlus_GraphicsDispose($hGfx_Buffer)
	_GDIPlus_BitmapDispose($hBmp_Buffer)
	_GDIPlus_GraphicsDispose($hGraphics)
	_GDIPlus_Shutdown()
EndFunc   ;==>Example
