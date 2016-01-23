; using a 2D array

#include <Array.au3>
#include <MsgBoxConstants.au3>

Local $avArray[6][2] = [ _
		["String0", "SubString0"], _
		["String1", "SubString1"], _
		["String2", "SubString2"], _
		["String3", "SubString3"], _
		["String4", "SubString4"], _
		["String5", "SubString5"]]

_ArrayDisplay($avArray, "$avArray")

Local $sSearch = InputBox("_ArraySearch() demo", "String to find?")
If @error Then Exit

Local $sColumn = InputBox("_ArraySearch() demo", "Column to search?")
If @error Then Exit
$sColumn = Int($sColumn)

Local $iIndex = _ArraySearch($avArray, $sSearch, 0, 0, 0, 1, 1, $sColumn)
If @error Then
	MsgBox($MB_SYSTEMMODAL, "Not Found", '"' & $sSearch & '" was not found on column ' & $sColumn & '.')
Else
	MsgBox($MB_SYSTEMMODAL, "Found", '"' & $sSearch & '" was found in the array at position ' & $iIndex & ' on column ' & $sColumn & '.')
EndIf
