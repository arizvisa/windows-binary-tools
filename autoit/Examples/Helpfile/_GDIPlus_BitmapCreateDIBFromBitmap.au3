; PNG work around by UEZ

#include <GDIPlus.au3>

#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>

; Create GUI
Local $hMainGUI = GUICreate("Show PNG", 210, 210)

_GUICtrlPic_Create("..\GUI\Torus.png", 10, 10);, 100, 100)

GUISetState(@SW_SHOW)

; Loop until the user exits.
While 1
	Switch GUIGetMsg()
		Case $GUI_EVENT_CLOSE
			ExitLoop

	EndSwitch
WEnd

; #INTERNAL_USE_ONLY#=================================================================================================
; Name...........: _GUICtrlPic_Create
; Description ...: Creates a Picture control for the GUI
; Syntax ........: _GUICtrlPic_Create($sFilename, $iLeft, $iTop, $iWidth, $iHeight, $iStyle = -1 , $iExStyle = -1)
; Parameters ....: $sFilename - Path of image file
; Author ........: UEZ
; Modified.......: Melba23, guinness, jpm
; Remarks .......: PNG image can be used.
; ====================================================================================================================
Func _GUICtrlPic_Create($sFilename, $iLeft, $iTop, $iWidth = -1, $iHeight = -1, $iStyle = -1, $iExStyle = -1)
	_GDIPlus_Startup()
	Local $idPic = GUICtrlCreatePic("", $iLeft, $iTop, $iWidth, $iHeight, $iStyle, $iExStyle)
	Local $hBitmap = _GDIPlus_BitmapCreateFromFile($sFilename)
	If $iWidth = -1 Then $iWidth = _GDIPlus_ImageGetWidth($hBitmap)
	If $iHeight = -1 Then $iHeight = _GDIPlus_ImageGetHeight($hBitmap)
	Local $hBitmap_Resized = _GDIPlus_BitmapCreateFromScan0($iWidth, $iHeight)
	Local $hBMP_Ctxt = _GDIPlus_ImageGetGraphicsContext($hBitmap_Resized)
	_GDIPlus_GraphicsSetInterpolationMode($hBMP_Ctxt, $GDIP_INTERPOLATIONMODE_HIGHQUALITYBICUBIC)
	_GDIPlus_GraphicsDrawImageRect($hBMP_Ctxt, $hBitmap, 0, 0, $iWidth, $iHeight)
	Local $hHBitmap = _GDIPlus_BitmapCreateDIBFromBitmap($hBitmap_Resized)
	Local $hPrevImage = GUICtrlSendMsg($idPic, $STM_SETIMAGE, 0, $hHBitmap) ; $STM_SETIMAGE = 0x0172
	_WinAPI_DeleteObject($hPrevImage); Delete Prev image if any
	_GDIPlus_BitmapDispose($hBitmap)
	_GDIPlus_BitmapDispose($hBitmap_Resized)
	_GDIPlus_GraphicsDispose($hBMP_Ctxt)
	_WinAPI_DeleteObject($hHBitmap)
	_GDIPlus_Shutdown()

	Return $idPic
EndFunc   ;==>_GUICtrlPic_Create
