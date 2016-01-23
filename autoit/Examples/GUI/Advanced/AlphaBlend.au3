#include <GDIPlus.au3>
#include <GuiConstantsEx.au3>
#include <WinAPI.au3>
#include <WindowsConstants.au3>

; ===============================================================================================================================
; Description ...: Shows how to create an alpha blended form
; Author ........: Paul Campbell (PaulIA)
; Notes .........: The images used for this demo MUST be 32 bpp with alpha channel
; Credits .......: Thanks to lod3n for supplying links to the technical documentation that was necessary to build this demo
; ===============================================================================================================================

; ===============================================================================================================================
; Global constants
; ===============================================================================================================================
Global Const $AC_SRC_ALPHA = 1

; ===============================================================================================================================
; Global variables
; ===============================================================================================================================
Global $g_hGUI2, $g_idSlider, $g_hImage

; Create GUI
Local $hGUI1 = GUICreate("Alpha Blend", 400, 100)
Local $idLabel1 = GUICtrlCreateLabel("Adjust slider to change opacity level: (0-255)", 84, 10, 380, 20)
$g_idSlider = GUICtrlCreateSlider(10, 32, 380, 40)
Local $idLabel2 = GUICtrlCreateLabel("Drag the layered window around your desktop", 80, 74, 380, 20)
GUICtrlSetLimit($g_idSlider, 255, 0)
GUICtrlSetData($g_idSlider, 255)
GUISetState()

; Create layered child window
$g_hGUI2 = GUICreate("Test", 250, 250, -1, -1, -1, $WS_EX_LAYERED, $hGUI1)

; Load layered image
_GDIPlus_Startup()
$g_hImage = _GDIPlus_ImageLoadFromFile(@ScriptDir & "\Images\Button.png")
;~ $g_hImage = _GDIPlus_ImageLoadFromFile(@ScriptDir & "\..\Torus.png")
SetBitmap($g_hGUI2, $g_hImage, 255)
GUISetState()

; Register notification messages
GUIRegisterMsg($WM_HSCROLL, "WM_HSCROLL")
GUIRegisterMsg($WM_NCHITTEST, "WM_NCHITTEST")

; Loop until user exits
Do
Until GUIGetMsg() = $GUI_EVENT_CLOSE

; Release resources
_GDIPlus_ImageDispose($g_hImage)
_GDIPlus_Shutdown()

; ===============================================================================================================================
; Handle the WM_HSCROLL notificaton so that we can change the opacity in real time
; ===============================================================================================================================
Func WM_HSCROLL($hWnd, $iMsg, $iParam, $lParam)
	#forceref $hWnd, $iMsg, $iParam, $lParam
	SetBitmap($g_hGUI2, $g_hImage, GUICtrlRead($g_idSlider))
EndFunc   ;==>WM_HSCROLL

; ===============================================================================================================================
; Handle the WM_NCHITTEST for the layered window so it can be dragged by clicking anywhere on the image.
; ===============================================================================================================================
Func WM_NCHITTEST($hWnd, $iMsg, $iParam, $lParam)
	#forceref $hWnd, $iMsg, $iParam, $lParam
	If ($hWnd = $g_hGUI2) And ($iMsg = $WM_NCHITTEST) Then Return $HTCAPTION
EndFunc   ;==>WM_NCHITTEST

; ===============================================================================================================================
; SetBitMap
; ===============================================================================================================================
Func SetBitmap($hGUI, $hImage, $iOpacity)
	Local $hScrDC, $hMemDC, $hBitmap, $hOld, $pSize, $tSize, $pSource, $tSource, $pBlend, $tBlend

	$hScrDC = _WinAPI_GetDC(0)
	$hMemDC = _WinAPI_CreateCompatibleDC($hScrDC)
	$hBitmap = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hImage)
	$hOld = _WinAPI_SelectObject($hMemDC, $hBitmap)
	$tSize = DllStructCreate($tagSIZE)
	$pSize = DllStructGetPtr($tSize)
	DllStructSetData($tSize, "X", _GDIPlus_ImageGetWidth($hImage))
	DllStructSetData($tSize, "Y", _GDIPlus_ImageGetHeight($hImage))
	$tSource = DllStructCreate($tagPOINT)
	$pSource = DllStructGetPtr($tSource)
	$tBlend = DllStructCreate($tagBLENDFUNCTION)
	$pBlend = DllStructGetPtr($tBlend)
	DllStructSetData($tBlend, "Alpha", $iOpacity)
	DllStructSetData($tBlend, "Format", $AC_SRC_ALPHA)
	_WinAPI_UpdateLayeredWindow($hGUI, $hScrDC, 0, $pSize, $hMemDC, $pSource, 0, $pBlend, $ULW_ALPHA)
	_WinAPI_ReleaseDC(0, $hScrDC)
	_WinAPI_SelectObject($hMemDC, $hOld)
	_WinAPI_DeleteObject($hBitmap)
	_WinAPI_DeleteDC($hMemDC)
EndFunc   ;==>SetBitmap
