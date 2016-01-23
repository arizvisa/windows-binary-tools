#include <Array.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()

	; Create 1D array to display
	Local $aArray_1D[5] = ["Item 0", "Item 1", "A longer Item 2 to show column expansion", "Item 3", "Item 4"]

	_ArrayDisplay($aArray_1D, "1D display")
	_ArrayDisplay($aArray_1D, "1D display transposed - 'Copy' buttons only", Default, 1 + 16) ; No buttons displayed

	; Create 2D array to display
	Local $aArray_2D[75][255]
	For $i = 0 To UBound($aArray_2D) - 1
		For $j = 0 To UBound($aArray_2D, 2) - 1
			$aArray_2D[$i][$j] = "Item " & StringFormat("%02i", $i) & StringFormat("%02i", $j)
		Next
	Next

	_ArrayDisplay($aArray_2D, "2D display") ; Note columns truncated
	_ArrayDisplay($aArray_2D, "2D display transposed", Default, 1) ; Note all array elements displayed

	ReDim $aArray_2D[20][10]
	$aArray_2D[5][5] = "A longer item to show column expansion"
	_ArrayDisplay($aArray_2D, "Expanded column - custom titles - alternate line color - no buttons or 'Row' column", Default, 32 + 64, Default, "AA|BB|CC|DD|EE|FF|GG|HH|II|JJ", Default, 0xDDFFDD)

	; Assign the user function to a variable to pass as a parameter
	Local $hUserFunction = _UserFunc

	$aArray_2D[5][5] = "Column alignment set to right"
	_ArrayDisplay($aArray_2D, "Range set - right align - copy column width - user function", "3:7|4:9", 2, 15, "AA|BB|CC|DD|EE|FF", Default, Default, $hUserFunction)
	_ArrayDisplay($aArray_2D, "Range set - right align - copy column width - transposed", "3:7|4:9", 3, 15, "AA|BB|CC|DD|EE|FF") ; Note no col names as transposed

	; Create non-array variable to force error - MsgBox displayed as $iFlags set
	Local $vVar = 0
	_ArrayDisplay($vVar, "MsgBox on Error", Default, 8)

EndFunc   ;==>Example

; Note that the user function MUST have TWO parameters even if you do not intend to use both of them
Func _UserFunc($aArray_2D, $aSelected)

	; But if a parameter is not used do this to prevent an Au3Check warning
	#forceref $aArray_2D

	_ArrayDisplay($aSelected, "Selected cols")

EndFunc   ;==>_UserFunc
