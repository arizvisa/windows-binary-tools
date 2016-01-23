#include <APISysConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WinAPIGdi.au3>
#include <WinAPIMisc.au3>
#include <WinAPISys.au3>
#include <WindowsConstants.au3>

Opt('TrayAutoPause', 0)

Global $g_ahPart[9]
; Load bitmaps (Mice*.bmp) that are required to display picture
For $i = 0 To 6
	$g_ahPart[$i] = _WinAPI_LoadImage(0, @ScriptDir & '\Extras\Mice' & $i & '.bmp', $IMAGE_BITMAP, 0, 0, $LR_LOADFROMFILE)
Next

; Copy some bitmaps for proper "Mice" drawing
$g_ahPart[7] = _WinAPI_CopyBitmap($g_ahPart[0])
$g_ahPart[8] = _WinAPI_CopyBitmap($g_ahPart[6])

; Create GUI
Global $g_hForm = GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), 160, 212, @DesktopWidth - 179, @DesktopHeight - 283, BitOR($WS_CAPTION, $WS_POPUP, $WS_SYSMENU), $WS_EX_TOPMOST)
Global $g_idPic = GUICtrlCreatePic('', 0, 0, 160, 160)
GUICtrlCreateGraphic(0, 160, 160, 1)
GUICtrlSetBkColor(-1, 0xDFDFDF)
GUICtrlCreateLabel('X:', 10, 170, 12, 14)
Global $g_aidLabel[3]
$g_aidLabel[0] = GUICtrlCreateLabel('', 23, 170, 30, 14)
GUICtrlCreateLabel('Y:', 10, 190, 12, 14)
$g_aidLabel[1] = GUICtrlCreateLabel('', 23, 190, 30, 14)
GUICtrlCreateLabel('Wheel:', 80, 170, 36, 14)
$g_aidLabel[2] = GUICtrlCreateLabel('', 117, 170, 30, 14)

_SetBitmap($g_idPic, $g_ahPart[0])

; To obtain the values of "UsagePage" and "Usage" members of this structure read HID Usage Tables documentation
; http://www.usb.org/developers/devclass_docs/HID1_11.pdf
Local $tRID = DllStructCreate($tagRAWINPUTDEVICE)
DllStructSetData($tRID, 'UsagePage', 0x01) ; Generic Desktop Controls
DllStructSetData($tRID, 'Usage', 0x02) ; Mouse
DllStructSetData($tRID, 'Flags', $RIDEV_INPUTSINK)
DllStructSetData($tRID, 'hTarget', $g_hForm)

; Register HID input to obtain row input from mice
_WinAPI_RegisterRawInputDevices($tRID)

; Register WM_INPUT message
GUIRegisterMsg($WM_INPUT, 'WM_INPUT')

GUISetState(@SW_SHOW)

Do
Until GUIGetMsg() = $GUI_EVENT_CLOSE

Func _SetBitmap($hWnd, $hBitmap, $bUpdate = False)
	If Not IsHWnd($hWnd) Then
		$hWnd = GUICtrlGetHandle($hWnd)
		If Not $hWnd Then
			Return 0
		EndIf
	EndIf

	$hBitmap = _WinAPI_CopyBitmap($hBitmap)
	If @error Then
		Return 0
	EndIf
	Local $hPrev = _SendMessage($hWnd, $STM_SETIMAGE, $IMAGE_BITMAP, $hBitmap)
	If $hPrev Then
		_WinAPI_DeleteObject($hPrev)
	EndIf
	$hPrev = _SendMessage($hWnd, $STM_GETIMAGE)
	If $hPrev <> $hBitmap Then
		_WinAPI_DeleteObject($hBitmap)
	EndIf
	If $bUpdate Then
		_WinAPI_UpdateWindow($hWnd)
	EndIf
	Return 1
EndFunc   ;==>_SetBitmap

Func WM_INPUT($hWnd, $iMsg, $wParam, $lParam)
	#forceref $iMsg, $wParam

	Switch $hWnd
		Case $g_hForm
			Local $tRIM = DllStructCreate($tagRAWINPUTMOUSE)
			If _WinAPI_GetRawInputData($lParam, $tRIM, DllStructGetSize($tRIM), $RID_INPUT) Then
				Local $iFlags = DllStructGetData($tRIM, 'Flags')
				Select
					Case BitAND($iFlags, $MOUSE_ATTRIBUTES_CHANGED)
						; You need to query the mouse attributes and update bitmap...
					Case Else

				EndSelect
				$iFlags = DllStructGetData($tRIM, 'ButtonFlags')
				If BitAND($iFlags, BitOR($RI_MOUSE_MIDDLE_BUTTON_DOWN, $RI_MOUSE_MIDDLE_BUTTON_UP, $RI_MOUSE_LEFT_BUTTON_DOWN, $RI_MOUSE_LEFT_BUTTON_UP, $RI_MOUSE_RIGHT_BUTTON_DOWN, $RI_MOUSE_RIGHT_BUTTON_UP)) Then
					Local $hDC = _WinAPI_CreateCompatibleDC(0)
					Local $hSv = _WinAPI_SelectObject($hDC, $g_ahPart[8])
					Select
						Case BitAND($iFlags, $RI_MOUSE_MIDDLE_BUTTON_DOWN)
							_WinAPI_DrawBitmap($hDC, 0, 0, $g_ahPart[5])
						Case BitAND($iFlags, $RI_MOUSE_MIDDLE_BUTTON_UP)
							_WinAPI_DrawBitmap($hDC, 0, 0, $g_ahPart[6])
					EndSelect
					_WinAPI_SelectObject($hDC, $g_ahPart[7])
					Select
						Case BitAND($iFlags, $RI_MOUSE_LEFT_BUTTON_DOWN)
							_WinAPI_DrawBitmap($hDC, 39, 25, $g_ahPart[1])
						Case BitAND($iFlags, $RI_MOUSE_LEFT_BUTTON_UP)
							_WinAPI_DrawBitmap($hDC, 39, 25, $g_ahPart[2])
						Case BitAND($iFlags, $RI_MOUSE_RIGHT_BUTTON_DOWN)
							_WinAPI_DrawBitmap($hDC, 81, 25, $g_ahPart[3])
						Case BitAND($iFlags, $RI_MOUSE_RIGHT_BUTTON_UP)
							_WinAPI_DrawBitmap($hDC, 81, 25, $g_ahPart[4])
					EndSelect
					_WinAPI_DrawBitmap($hDC, 74, 33, $g_ahPart[8])
					_WinAPI_SelectObject($hDC, $hSv)
					_WinAPI_DeleteDC($hDC)
					_SetBitmap($g_idPic, $g_ahPart[7])
				EndIf
				Local $aData = MouseGetPos()
				For $i = 0 To 1
					If StringCompare(GUICtrlRead($g_aidLabel[$i]), $aData[$i]) Then
						GUICtrlSetData($g_aidLabel[$i], $aData[$i])
					EndIf
				Next
				If BitAND($iFlags, $RI_MOUSE_WHEEL) Then
					$aData = _WinAPI_WordToShort(DllStructGetData($tRIM, 'ButtonData'))
					If $aData > 0 Then
						$aData = 'Up'
					Else
						$aData = 'Down'
					EndIf
				Else
					$aData = ''
				EndIf
				If StringCompare(GUICtrlRead($g_aidLabel[2]), $aData) Then
					GUICtrlSetData($g_aidLabel[2], $aData)
				EndIf
			EndIf
	EndSwitch
	Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_INPUT
