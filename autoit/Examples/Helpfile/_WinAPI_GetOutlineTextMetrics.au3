#include <FontConstants.au3>
#include <WinAPIGdi.au3>

; Select "Arial" font to DC and retrieve $tagOUTLINETEXTMETRIC structure
Local $hDC = _WinAPI_GetDC(0)
Local $hFont = _WinAPI_CreateFont(24, 0, 0, 0, $FW_NORMAL, 0, 0, 0, $DEFAULT_CHARSET, $OUT_DEFAULT_PRECIS, $CLIP_DEFAULT_PRECIS, $ANTIALIASED_QUALITY, $DEFAULT_PITCH, 'Arial')
Local $hSv = _WinAPI_SelectObject($hDC, $hFont)
Local $tOLTM = _WinAPI_GetOutlineTextMetrics($hDC)
_WinAPI_SelectObject($hDC, $hSv)
_WinAPI_ReleaseDC(0, $hDC)

If IsDllStruct($tOLTM) Then
	ConsoleWrite('Family name:   ' & _otm($tOLTM, 'otmFamilyName') & @CRLF)
	ConsoleWrite('Typeface name: ' & _otm($tOLTM, 'otmFaceName') & @CRLF)
	ConsoleWrite('Style name     ' & _otm($tOLTM, 'otmStyleName') & @CRLF)
	ConsoleWrite('Full name:     ' & _otm($tOLTM, 'otmFullName') & @CRLF)
EndIf

Func _otm(ByRef $tOLTM, $sName)
	Return _WinAPI_GetString(DllStructGetPtr($tOLTM) + DllStructGetData($tOLTM, $sName))
EndFunc   ;==>_otm
