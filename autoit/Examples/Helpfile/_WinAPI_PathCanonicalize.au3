#include <WinAPIShPath.au3>

Local $aPath[5] = ['A:\Dir1\.\Dir2\..\Dir3', 'A:\Dir1\..\Dir2\.\Dir3', 'A:\Dir1\Dir2\.\Dir3\..\Dir4', 'A:\Dir1\.\Dir2\.\Dir3\..\Dir4\..', 'A:\..']

For $i = 0 To 4
	ConsoleWrite($aPath[$i] & ' => ' & _WinAPI_PathCanonicalize($aPath[$i]) & @CRLF)
Next
