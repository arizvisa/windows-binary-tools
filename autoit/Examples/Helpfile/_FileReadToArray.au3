#include <Array.au3>
#include <File.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $aRetArray, $sFilePath = @TempDir & "\Test.txt"

	; Create 1D array
	Local $aArray[] = ["0", "1", "2", "3", "4"]
	; Write it to file
	_FileWriteFromArray($sFilePath, $aArray, Default, Default, @CRLF)
	Sleep(1000)

	; Re-read it - with count
	_FileReadToArray($sFilePath, $aRetArray)
	_ArrayDisplay($aRetArray, "1D array - count", Default, 8)

	; Re-read it - without count
	_FileReadToArray($sFilePath, $aRetArray, $FRTA_NOCOUNT)
	_ArrayDisplay($aRetArray, "1D array - no count", Default, 8)

	; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	; Create "square" 2D array
	Local $aArray[][] = [ _
			["00", "01", "02", "03"], _
			["10", "11", "12", "13"], _
			["20", "21", "22", "23"], _
			["30", "31", "32", "33"]]
	_ArrayDisplay($aArray, "Original", Default, 8)
	; Write it to file
	_FileWriteFromArray($sFilePath, $aArray, Default, Default, ",")
	Sleep(1000)

	; Re-read it - with count
	_FileReadToArray($sFilePath, $aRetArray, Default, ",")
	_ArrayDisplay($aRetArray, "2D array - count", Default, 8)

	; Re-read it - without count
	_FileReadToArray($sFilePath, $aRetArray, $FRTA_NOCOUNT, ",")
	_ArrayDisplay($aRetArray, "2D array - no count", Default, 8)

	; Read into "array of arrays" with count
	_FileReadToArray($sFilePath, $aRetArray, $FRTA_COUNT + $FRTA_INTARRAYS, ",")
	_ArrayDisplay($aRetArray, "Array of arrays - count", Default, 8)
	; Now look inside the arrays inside the returned array
	_ArrayDisplay($aRetArray[1], "Array 1 inside RetArray - count", Default, 8)

	; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	; Rewrite 2D array with multiple delimiters
	_FileWriteFromArray($sFilePath, $aArray, Default, Default, ":|")
	Sleep(1000)

	; Re-read with each delimiter acting as a split point
	_FileReadToArray($sFilePath, $aRetArray, $FRTA_NOCOUNT, ":|")
	_ArrayDisplay($aRetArray, "Split on each character", Default, 8)

	; Re-read with whole delimiter acting as a split point
	_FileReadToArray($sFilePath, $aRetArray, $FRTA_NOCOUNT + $FRTA_ENTIRESPLIT, ":|")
	_ArrayDisplay($aRetArray, "Split on full delimiter", Default, 8)

	FileDelete($sFilePath)
EndFunc   ;==>Example
