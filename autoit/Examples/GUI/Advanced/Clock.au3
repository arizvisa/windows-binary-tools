#include <GDIPlus.au3>
#include <GuiConstantsEx.au3>
#include <WinAPI.au3>
#include <WindowsConstants.au3>

; ===============================================================================================================================
; Description ...: Simple clock using layered windows
; Author ........: Paul Campbell (PaulIA)
; Notes .........:
; ===============================================================================================================================

; ===============================================================================================================================
; Global constants
; ===============================================================================================================================

Global Const $g_iCENTER = 200
Global Const $g_iDOT_OPACITY = 250
Global Const $g_iHOUR_RAD = 140
Global Const $g_iMIN_RAD = 200
Global Const $g_iOPACITY = 128
Global Const $PI = 3.1415926535897932384626433832795
Global Const $g_iRADIUS = 200
Global Const $g_iSEC_RAD = 200
Global Const $g_iTICK_LEN = 0.02

Global Const $AC_SRC_ALPHA = 1

Global Enum $eSRC_DC = 0, $eMEM_DC, $eBITMAP, $eWIDTH, $eHEIGHT, $eGRAPHIC, $ePEN, $eCAP, $eBRUSH, $eFORMAT, $eFAMILY, $eFONT, $eLAYOUT, $eLAST

; ===============================================================================================================================
; Global variables
; ===============================================================================================================================

Global $g_hDial, $g_hTime, $g_hHour, $g_hMin, $g_hSec, $g_hDot, $g_aTime, $g_aHour, $g_aMin, $g_aSec, $g_aCurr[3][2], $g_aLast[3][2]

; ===============================================================================================================================
; Main
; ===============================================================================================================================

ClockInit()
DialDraw()
Draw()
DotDraw()
ClockLoop()
ClockDone()

; ===============================================================================================================================
; Finalize clock
; ===============================================================================================================================
Func ClockDone()
	; Finalize GDI+ resources
	TimeDone()
	HourDone()
	MinDone()
	SecDone()

	; Finalize GDI+ library
	_GDIPlus_Shutdown()
EndFunc   ;==>ClockDone

; ===============================================================================================================================
; Initialize clock
; ===============================================================================================================================
Func ClockInit()
	Local $iX, $iY

	; Calculate the dial frame caption size
	$iX = -(_WinAPI_GetSystemMetrics($SM_CXFRAME))
	$iY = -(_WinAPI_GetSystemMetrics($SM_CYCAPTION) + _WinAPI_GetSystemMetrics($SM_CYFRAME))

	; Allocate the window resources
	$g_hDial = GUICreate("Clock", $g_iRADIUS * 2, $g_iRADIUS * 2, -1, -1, 0, BitOR($WS_EX_LAYERED, $WS_EX_TOPMOST))
	GUISetState()
	$g_hTime = GUICreate("Time", $g_iRADIUS * 2, $g_iRADIUS * 2, $iX, $iY, 0, BitOR($WS_EX_LAYERED, $WS_EX_MDICHILD), $g_hDial)
	GUISetState()
	$g_hHour = GUICreate("Hour", $g_iRADIUS * 2, $g_iRADIUS * 2, $iX, $iY, 0, BitOR($WS_EX_LAYERED, $WS_EX_MDICHILD), $g_hDial)
	GUISetState()
	$g_hMin = GUICreate("Min", $g_iRADIUS * 2, $g_iRADIUS * 2, $iX, $iY, 0, BitOR($WS_EX_LAYERED, $WS_EX_MDICHILD), $g_hDial)
	GUISetState()
	$g_hSec = GUICreate("Sec", $g_iRADIUS * 2, $g_iRADIUS * 2, $iX, $iY, 0, BitOR($WS_EX_LAYERED, $WS_EX_MDICHILD), $g_hDial)
	GUISetState()
	$g_hDot = GUICreate("Dot", $g_iRADIUS * 2, $g_iRADIUS * 2, $iX, $iY, 0, BitOR($WS_EX_LAYERED, $WS_EX_MDICHILD), $g_hDial)
	GUISetState()

	; Initialize GDI+ library
	_GDIPlus_Startup()

	; Initialize GDI+ resources
	TimeInit()
	HourInit()
	MinInit()
	SecInit()

	; Hook non client hit test message so we can move the clock
	GUIRegisterMsg($WM_NCHITTEST, "WM_NCHITTEST")
EndFunc   ;==>ClockInit

; ===============================================================================================================================
; Loop until user exits
; ===============================================================================================================================
Func ClockLoop()
	Do
		Draw()
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
EndFunc   ;==>ClockLoop

; ===============================================================================================================================
; Draw the center dot
; ===============================================================================================================================
Func DotDraw()
	Local $aDot

	$aDot = ResourceInit($g_iRADIUS * 2, $g_iRADIUS * 2)
	_GDIPlus_GraphicsFillEllipse($aDot[$eGRAPHIC], $g_iRADIUS - 10, $g_iRADIUS - 10, 20, 20)
	ResourceSet($g_hDot, $aDot, $g_iDOT_OPACITY)
	ResourceDone($aDot)
EndFunc   ;==>DotDraw

; ===============================================================================================================================
; Draw the clock elements
; ===============================================================================================================================
Func Draw()
	; Calculate current time element position
	$g_aLast = $g_aCurr
	$g_aCurr[0][0] = $g_iCENTER + Cos(TimeToRadians("sec")) * $g_iSEC_RAD
	$g_aCurr[0][1] = $g_iCENTER - Sin(TimeToRadians("sec")) * $g_iSEC_RAD
	$g_aCurr[1][0] = $g_iCENTER + Cos(TimeToRadians("min")) * $g_iMIN_RAD
	$g_aCurr[1][1] = $g_iCENTER - Sin(TimeToRadians("min")) * $g_iMIN_RAD
	$g_aCurr[2][0] = $g_iCENTER + Cos(TimeToRadians("hour")) * $g_iHOUR_RAD
	$g_aCurr[2][1] = $g_iCENTER - Sin(TimeToRadians("hour")) * $g_iHOUR_RAD

	; Draw time elements
	TimeDraw()
	HourDraw()
	MinDraw()
	SecDraw()
EndFunc   ;==>Draw

; ===============================================================================================================================
; Draw the clock dial
; ===============================================================================================================================
Func DialDraw()
	Local $aDial, $hPen1, $hPen2, $iI, $iN, $iX1, $iY1, $iX2, $iY2

	$aDial = ResourceInit($g_iRADIUS * 2, $g_iRADIUS * 2)
	$hPen1 = _GDIPlus_PenCreate()
	$hPen2 = _GDIPlus_PenCreate(0xFF0000FF, 4)
	For $iI = 0 To 2 * $PI Step $PI / 30
		$iX1 = $g_iCENTER + Cos($iI) * ($g_iRADIUS * (1.00 - $g_iTICK_LEN))
		$iY1 = $g_iCENTER - Sin($iI) * ($g_iRADIUS * (1.00 - $g_iTICK_LEN))
		$iX2 = $g_iCENTER + Cos($iI) * $g_iRADIUS
		$iY2 = $g_iCENTER - Sin($iI) * $g_iRADIUS
		If Mod($iN, 5) = 0 Then
			_GDIPlus_GraphicsDrawLine($aDial[$eGRAPHIC], $iX1, $iY1, $iX2, $iY2, $hPen2)
		Else
			_GDIPlus_GraphicsDrawLine($aDial[$eGRAPHIC], $iX1, $iY1, $iX2, $iY2, $hPen1)
		EndIf
		$iN += 1
	Next
	_GDIPlus_PenDispose($hPen2)
	_GDIPlus_PenDispose($hPen1)

	ResourceSet($g_hDial, $aDial)
	ResourceDone($aDial)
EndFunc   ;==>DialDraw

; ===============================================================================================================================
; Finalize resources for the hour hand
; ===============================================================================================================================
Func HourDone()
	_GDIPlus_PenDispose($g_aHour[$ePEN])
	_GDIPlus_ArrowCapDispose($g_aHour[$eCAP])
	ResourceDone($g_aHour)
EndFunc   ;==>HourDone

; ===============================================================================================================================
; Draw the hour hand
; ===============================================================================================================================
Func HourDraw()
	If ($g_aLast[2][0] = $g_aCurr[2][0]) And ($g_aLast[2][1] = $g_aCurr[2][1]) Then Return
	_GDIPlus_GraphicsDrawLine($g_aHour[$eGRAPHIC], $g_iCENTER, $g_iCENTER, $g_aCurr[2][0], $g_aCurr[2][1], $g_aHour[$ePEN])
	ResourceSet($g_hHour, $g_aHour)
EndFunc   ;==>HourDraw

; ===============================================================================================================================
; Initialize resources for the hour hand
; ===============================================================================================================================
Func HourInit()
	$g_aHour = ResourceInit($g_iRADIUS * 2, $g_iRADIUS * 2)
	$g_aHour[$ePEN] = _GDIPlus_PenCreate(0xFFFF00FF)
	$g_aHour[$eCAP] = _GDIPlus_ArrowCapCreate($g_iHOUR_RAD / 2, 8)
	_GDIPlus_PenSetCustomEndCap($g_aHour[$ePEN], $g_aHour[$eCAP])
EndFunc   ;==>HourInit

; ===============================================================================================================================
; Finalize resources for the minute hand
; ===============================================================================================================================
Func MinDone()
	_GDIPlus_PenDispose($g_aMin[$ePEN])
	_GDIPlus_ArrowCapDispose($g_aMin[$eCAP])
	ResourceDone($g_aMin)
EndFunc   ;==>MinDone

; ===============================================================================================================================
; Draw the minute hand
; ===============================================================================================================================
Func MinDraw()
	If ($g_aLast[1][0] = $g_aCurr[1][0]) And ($g_aLast[1][1] = $g_aCurr[1][1]) Then Return
	_GDIPlus_GraphicsFillRect($g_aMin[$eGRAPHIC], 0, 0, $g_iRADIUS * 2, $g_iRADIUS * 2)
	_GDIPlus_GraphicsDrawLine($g_aMin[$eGRAPHIC], $g_iCENTER, $g_iCENTER, $g_aCurr[1][0], $g_aCurr[1][1], $g_aMin[$ePEN])
	ResourceSet($g_hMin, $g_aMin)
EndFunc   ;==>MinDraw

; ===============================================================================================================================
; Initialize resources for the minute hand
; ===============================================================================================================================
Func MinInit()
	$g_aMin = ResourceInit($g_iRADIUS * 2, $g_iRADIUS * 2)
	$g_aMin[$ePEN] = _GDIPlus_PenCreate(0xFFFF0000)
	$g_aMin[$eCAP] = _GDIPlus_ArrowCapCreate($g_iMIN_RAD / 2, 8)
	_GDIPlus_PenSetCustomEndCap($g_aMin[$ePEN], $g_aMin[$eCAP])
EndFunc   ;==>MinInit

; ===============================================================================================================================
; Finalize resources for the second hand
; ===============================================================================================================================
Func SecDone()
	_GDIPlus_PenDispose($g_aSec[$ePEN])
	ResourceDone($g_aSec)
EndFunc   ;==>SecDone

; ===============================================================================================================================
; Draw the second hand
; ===============================================================================================================================
Func SecDraw()
	If ($g_aLast[0][0] = $g_aCurr[0][0]) And ($g_aLast[0][1] = $g_aCurr[0][1]) Then Return
	_GDIPlus_GraphicsFillRect($g_aSec[$eGRAPHIC], 0, 0, $g_iRADIUS * 2, $g_iRADIUS * 2)
	_GDIPlus_GraphicsDrawLine($g_aSec[$eGRAPHIC], $g_iCENTER, $g_iCENTER, $g_aCurr[0][0], $g_aCurr[0][1], $g_aSec[$ePEN])
	ResourceSet($g_hSec, $g_aSec)
EndFunc   ;==>SecDraw

; ===============================================================================================================================
; Initialize resources for the second hand
; ===============================================================================================================================
Func SecInit()
	$g_aSec = ResourceInit($g_iRADIUS * 2, $g_iRADIUS * 2)
	$g_aSec[$ePEN] = _GDIPlus_PenCreate(0xFF000000)
EndFunc   ;==>SecInit

; ===============================================================================================================================
; Finalize drawing resources
; ===============================================================================================================================
Func ResourceDone(ByRef $aInfo)
	_GDIPlus_GraphicsDispose($aInfo[$eGRAPHIC])
	_WinAPI_ReleaseDC(0, $aInfo[$eSRC_DC])
	_WinAPI_DeleteObject($aInfo[$eBITMAP])
	_WinAPI_DeleteDC($aInfo[$eMEM_DC])
EndFunc   ;==>ResourceDone

; ===============================================================================================================================
; Initialize bitmap resources
; ===============================================================================================================================
Func ResourceInit($iWidth, $iHeight)
	Local $aInfo[$eLAST + 1]

	$aInfo[$eSRC_DC] = _WinAPI_GetDC(0)
	$aInfo[$eMEM_DC] = _WinAPI_CreateCompatibleDC($aInfo[$eSRC_DC])
	$aInfo[$eBITMAP] = _WinAPI_CreateCompatibleBitmap($aInfo[$eSRC_DC], $iWidth, $iHeight)
	_WinAPI_SelectObject($aInfo[$eMEM_DC], $aInfo[$eBITMAP])
	$aInfo[$eWIDTH] = $iWidth
	$aInfo[$eHEIGHT] = $iHeight
	$aInfo[$eGRAPHIC] = _GDIPlus_GraphicsCreateFromHDC($aInfo[$eMEM_DC])
	_GDIPlus_GraphicsFillRect($aInfo[$eGRAPHIC], 0, 0, $g_iRADIUS * 2, $g_iRADIUS * 2)
	Return $aInfo
EndFunc   ;==>ResourceInit

; ===============================================================================================================================
; Update layered window with resource information
; ===============================================================================================================================
Func ResourceSet($hGUI, ByRef $aInfo, $iAlpha = -1)
	Local $pSize, $tSize, $pSource, $tSource, $pBlend, $tBlend

	If $iAlpha = -1 Then $iAlpha = $g_iOPACITY
	$tSize = DllStructCreate($tagSIZE)
	$pSize = DllStructGetPtr($tSize)
	DllStructSetData($tSize, "X", $aInfo[$eWIDTH])
	DllStructSetData($tSize, "Y", $aInfo[$eHEIGHT])
	$tSource = DllStructCreate($tagPOINT)
	$pSource = DllStructGetPtr($tSource)
	$tBlend = DllStructCreate($tagBLENDFUNCTION)
	$pBlend = DllStructGetPtr($tBlend)
	DllStructSetData($tBlend, "Alpha", $iAlpha)
	DllStructSetData($tBlend, "Format", $AC_SRC_ALPHA)
	_WinAPI_UpdateLayeredWindow($hGUI, $aInfo[$eSRC_DC], 0, $pSize, $aInfo[$eMEM_DC], $pSource, 0, $pBlend, $ULW_ALPHA)
EndFunc   ;==>ResourceSet

; ===============================================================================================================================
; Finalize resources for the digital time
; ===============================================================================================================================
Func TimeDone()
	_GDIPlus_FontDispose($g_aTime[$eFONT])
	_GDIPlus_FontFamilyDispose($g_aTime[$eFAMILY])
	_GDIPlus_StringFormatDispose($g_aTime[$eFORMAT])
	_GDIPlus_BrushDispose($g_aTime[$eBRUSH])
	ResourceDone($g_aTime)
EndFunc   ;==>TimeDone

; ===============================================================================================================================
; Draw the digital time
; ===============================================================================================================================
Func TimeDraw()
	Local $sString, $aSize

	If ($g_aLast[0][0] = $g_aCurr[0][0]) And ($g_aLast[0][1] = $g_aCurr[0][1]) Then Return
	$sString = StringFormat("%02d:%02d:%02d", @HOUR, @MIN, @SEC)
	$aSize = _GDIPlus_GraphicsMeasureString($g_aTime[$eGRAPHIC], $sString, $g_aTime[$eFONT], $g_aTime[$eLAYOUT], $g_aTime[$eFORMAT])
	DllStructSetData($g_aTime[$eLAYOUT], "X", $g_iRADIUS - (DllStructGetData($aSize[0], "Width") / 2))
	DllStructSetData($g_aTime[$eLAYOUT], "Y", $g_iRADIUS / 3)
	_GDIPlus_GraphicsFillRect($g_aTime[$eGRAPHIC], 0, 0, $g_iRADIUS * 2, $g_iRADIUS * 2)
	_GDIPlus_GraphicsDrawStringEx($g_aTime[$eGRAPHIC], $sString, $g_aTime[$eFONT], $g_aTime[$eLAYOUT], $g_aTime[$eFORMAT], $g_aTime[$eBRUSH])
	ResourceSet($g_hTime, $g_aTime)
EndFunc   ;==>TimeDraw

; ===============================================================================================================================
; Initialize resources for the digital time
; ===============================================================================================================================
Func TimeInit()
	$g_aTime = ResourceInit($g_iRADIUS * 2, $g_iRADIUS * 2)
	$g_aTime[$eBRUSH] = _GDIPlus_BrushCreateSolid(0xFF008080)
	$g_aTime[$eFORMAT] = _GDIPlus_StringFormatCreate()
	$g_aTime[$eFAMILY] = _GDIPlus_FontFamilyCreate("Arial")
	$g_aTime[$eFONT] = _GDIPlus_FontCreate($g_aTime[$eFAMILY], 24, 1)
	$g_aTime[$eLAYOUT] = _GDIPlus_RectFCreate(0, 0, $g_iRADIUS * 2, 40)
EndFunc   ;==>TimeInit

; ===============================================================================================================================
; Convert time value to radians
; ===============================================================================================================================
Func TimeToRadians($sTimeType)
	Switch $sTimeType
		Case "sec"
			Return ($PI / 2) - (@SEC * ($PI / 30))
		Case "min"
			Return ($PI / 2) - (@MIN * ($PI / 30)) - (Int(@SEC / 10) * ($PI / 180))
		Case "hour"
			Return ($PI / 2) - (@HOUR * ($PI / 6)) - (@MIN / 12) * ($PI / 30)
	EndSwitch
EndFunc   ;==>TimeToRadians

; ===============================================================================================================================
; Handle the WM_NCHITTEST message so our window can be dragged
; ===============================================================================================================================
Func WM_NCHITTEST($hWnd, $iMsg, $iParam, $lParam)
	#forceref  $iMsg, $iParam, $lParam
	If $hWnd = $g_hDial Then Return $HTCAPTION
EndFunc   ;==>WM_NCHITTEST
