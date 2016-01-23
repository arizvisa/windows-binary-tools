#include <WinAPIGdi.au3>

Local $hEmf = _WinAPI_GetEnhMetaFile(@ScriptDir & '\Extras\Flag.emf')
Local $tSIZE = _WinAPI_GetEnhMetaFileDimension($hEmf)
_WinAPI_DeleteEnhMetaFile($hEmf)

ConsoleWrite(DllStructGetData($tSIZE, 'X') & ' x ' & DllStructGetData($tSIZE, 'Y') & @CRLF)
