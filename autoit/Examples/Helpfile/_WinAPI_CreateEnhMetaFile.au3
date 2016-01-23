#include <MsgBoxConstants.au3>
#include <WinAPIGdi.au3>

Local Const $sEmf = @TempDir & '\Test.emf'

If FileExists($sEmf) Then
	If MsgBox(BitOR($MB_YESNOCANCEL, $MB_ICONQUESTION, $MB_DEFBUTTON2, $MB_SYSTEMMODAL), 'Create Enhanced Metafile', $sEmf & ' is already exists.' & @CRLF & @CRLF & 'Do you want to replace it?') <> 6 Then
		Exit
	EndIf
	If Not FileDelete($sEmf) Then
		MsgBox(BitOR($MB_ICONERROR, $MB_SYSTEMMODAL), 'Create Enhanced Metafile', 'Unable to delete file.')
		Exit
	EndIf
EndIf

; Create device context for an enhanced-format metafile
Local $tRECT = _WinAPI_CreateRect(0, 0, 250, 250)
Local $hDC = _WinAPI_CreateEnhMetaFile(0, $tRECT, 1, @TempDir & '\Test.emf')

; Draw objects
Local $hBrush = _WinAPI_SelectObject($hDC, _WinAPI_GetStockObject($DC_BRUSH))
Local $hPen = _WinAPI_SelectObject($hDC, _WinAPI_GetStockObject($NULL_PEN))
_WinAPI_SetDCBrushColor($hDC, 0xAA0000)
_WinAPI_Rectangle($hDC, $tRECT)
_WinAPI_SetDCBrushColor($hDC, 0xFFFFFF)
Local $aPoint[10][2] = [[0, 90], [95, 90], [125, 0], [154, 90], [250, 90], [172, 147], [202, 238], [125, 181], [47, 238], [77, 147]]
Local $hRgn = _WinAPI_CreatePolygonRgn($aPoint)
_WinAPI_OffsetRgn($hRgn, 0, 6)
_WinAPI_PaintRgn($hDC, $hRgn)

; Release objects
_WinAPI_SelectObject($hDC, $hBrush)
_WinAPI_SelectObject($hDC, $hPen)
Local $hEmf = _WinAPI_CloseEnhMetaFile($hDC)
_WinAPI_DeleteEnhMetaFile($hEmf)
_WinAPI_DeleteObject($hRgn)

; Show created .emf file into the Microsoft Paint
If FileExists($sEmf) Then
	ShellExecute(@SystemDir & '\mspaint.exe', $sEmf)
EndIf
