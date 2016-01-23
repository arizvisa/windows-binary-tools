#include <APIThemeConstants.au3>
#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>
#include <StaticConstants.au3>
#include <WinAPIGdi.au3>
#include <WinAPIShellEx.au3>
#include <WinAPISys.au3>
#include <WinAPITheme.au3>
#include <WindowsConstants.au3>

If _WinAPI_GetVersion() < '6.0' Then
	MsgBox(BitOR($MB_ICONERROR, $MB_SYSTEMMODAL), 'Error', 'Require Windows Vista or later.')
	Exit
EndIf

; Load bitmap and icon
Local $hTech = _WinAPI_LoadImage(0, @ScriptDir & '\Extras\Tech.bmp', $IMAGE_BITMAP, 0, 0, $LR_LOADFROMFILE)
Local $hIcon = _WinAPI_ShellExtractIcon(@ScriptDir & '\Extras\NVIDIA.ico', 0, 256, 256)

; Create GUI
GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), 302, 302, -1, -1, $WS_POPUP, $WS_EX_TOPMOST)
GUICtrlCreatePic('', 0, 0, 302, 302)
Local $hPic = GUICtrlGetHandle(-1)

; Initialize buffered painting
_WinAPI_BufferedPaintInit()

; Select bitmap into DC
Local $hDC = _WinAPI_GetDC($hPic)
Local $hSrcDC = _WinAPI_CreateCompatibleDC($hDC)
Local $hSrcSv = _WinAPI_SelectObject($hSrcDC, $hTech)

; Begin buffered paint operation
Local $hNewDC
Local $hBP = _WinAPI_BeginBufferedPaint($hSrcDC, _WinAPI_CreateRectEx(22, 22, 256, 256), $hNewDC, $BPBF_COMPATIBLEBITMAP, 0, 0, 160)

; Draw icon with alpha
_WinAPI_DrawIconEx($hNewDC, 22, 22, $hIcon)

; End buffered paint operation and update the reference DC
_WinAPI_EndBufferedPaint($hBP)

; Merge bitmap and release resources
Local $hDestDC = _WinAPI_CreateCompatibleDC($hDC)
Local $hBitmap = _WinAPI_CreateCompatibleBitmapEx($hDC, 302, 302, 0x606060)
Local $hDestSv = _WinAPI_SelectObject($hDestDC, $hBitmap)
_WinAPI_BitBlt($hDestDC, 1, 1, 300, 300, $hSrcDC, 0, 0, $MERGECOPY)
_WinAPI_SelectObject($hDestDC, $hDestSv)
_WinAPI_DeleteDC($hDestDC)
_WinAPI_SelectObject($hSrcDC, $hSrcSv)
_WinAPI_DeleteDC($hSrcDC)
_WinAPI_ReleaseDC($hPic, $hDC)
_WinAPI_DeleteObject($hTech)
_WinAPI_DestroyIcon($hIcon)

; Set bitmap to control
_SendMessage($hPic, $STM_SETIMAGE, 0, $hBitmap)
Local $hObj = _SendMessage($hPic, $STM_GETIMAGE)
If $hObj <> $hBitmap Then
	_WinAPI_DeleteObject($hBitmap)
EndIf

; Closes down buffered painting
_WinAPI_BufferedPaintUnInit()

GUISetState(@SW_SHOW)

Do
Until GUIGetMsg() = $GUI_EVENT_CLOSE
