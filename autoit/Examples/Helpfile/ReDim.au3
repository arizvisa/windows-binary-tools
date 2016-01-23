#include <Array.au3>

Example()

Func Example()
	Local $aArray[1] ; Create a 1-dimensional array with 1 element.
	For $i = 0 To 100 ; Loop through values 0 to 100 to access the index of the array
		ReDim $aArray[UBound($aArray) + 1] ; Determine the current size of the array and increase by 1
		$aArray[$i] = $i
	Next
	_ArrayDisplay($aArray) ; Display the array.
EndFunc   ;==>Example
