; Create an array of object references to all current browser instances
; The first array element will contain the number of instances found

#include <IE.au3>
#include <MsgBoxConstants.au3>

Local $aIE[1]
$aIE[0] = 0

Local $i = 1, $oIE
While 1
	$oIE = _IEAttach("", "instance", $i)
	If @error = $_IEStatus_NoMatch Then ExitLoop
	ReDim $aIE[$i + 1]
	$aIE[$i] = $oIE
	$aIE[0] = $i
	$i += 1
WEnd

MsgBox($MB_SYSTEMMODAL, "Browsers Found", "Number of browser instances in the array: " & $aIE[0])
