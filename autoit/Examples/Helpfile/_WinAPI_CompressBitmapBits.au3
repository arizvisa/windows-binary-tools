#include <APIGdiConstants.au3>
#include <MsgBoxConstants.au3>
#include <WinAPIGdi.au3>
#include <WinAPISys.au3>

; Load image
Local $hSource = _WinAPI_LoadImage(0, @ScriptDir & '\Extras\AutoIt.bmp', $IMAGE_BITMAP, 0, 0, BitOR($LR_LOADFROMFILE, $LR_CREATEDIBSECTION))

; Resize bitmap to 256x256 pixels
Local $hBitmap = _WinAPI_AdjustBitmap($hSource, 256, 256, $HALFTONE)

; Create compressed PNG data
Local $pData = 0
Local $iLength = _WinAPI_CompressBitmapBits($hBitmap, $pData, 2)

; Create .ico file
If Not @error Then
	Local $tICO = DllStructCreate('align 1;ushort Reserved;ushort Type;ushort Count;byte Header[20]')
	Local $tHDR = DllStructCreate('byte Width;byte Height;byte ColorCount;byte Reserved;ushort Planes;ushort BitCount;long Size;long Offset', DllStructGetPtr($tICO, 'Header'))
	DllStructSetData($tICO, 'Reserved', 0)
	DllStructSetData($tICO, 'Type', 1)
	DllStructSetData($tICO, 'Count', 1)
	DllStructSetData($tHDR, 'Width', 0)
	DllStructSetData($tHDR, 'Height', 0)
	DllStructSetData($tHDR, 'ColorCount', 0)
	DllStructSetData($tHDR, 'Reserved', 0)
	DllStructSetData($tHDR, 'Planes', 1)
	DllStructSetData($tHDR, 'BitCount', 32)
	DllStructSetData($tHDR, 'Size', $iLength)
	DllStructSetData($tHDR, 'Offset', DllStructGetSize($tICO))
	Local $hFile = _WinAPI_CreateFile(@TempDir & '\MyIcon.ico', 1, 4)
	Local $iBytes
	_WinAPI_WriteFile($hFile, $tICO, DllStructGetSize($tICO), $iBytes)
	_WinAPI_WriteFile($hFile, $pData, $iLength, $iBytes)
	_WinAPI_CloseHandle($hFile)
	ShellExecute("MsPaint", '"' & @TempDir & '\MyIcon.ico' & '"')
Else
	MsgBox($MB_SYSTEMMODAL, "Error", "_WinAPI_CompressBitmapBits() failed (@error = " & @error & ")")
EndIf

; Delete unnecessary bitmaps
_WinAPI_DeleteObject($hSource)
_WinAPI_DeleteObject($hBitmap)

; Free memory
_WinAPI_FreeMemory($pData)
