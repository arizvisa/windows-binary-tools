#include <MsgBoxConstants.au3>

Example()

Func Example()
	Local $aArray[1] = [0], $iArrayTotal = 5000, $iCount = 0, $iDimension = 0

	Local $hTimer = TimerInit() ; Start the timer.
	For $i = 1 To $iArrayTotal
		; Returns True if ReDimmed or False if it wasn"t. This uses ByRef, so just pass the Array and a previously declared variable for monitoring the dimension.
		If ReDim1D($aArray, $iDimension) Then
			$iCount += 1 ; If the array was ReDimmed then add to the ReDim count for output at the end of the example.
		EndIf
		$aArray[0] += 1 ; Increase zeroth index [0] by a value of 1.
		$aArray[$i] = "Row " & $i & ": Col 0" ; Add random data.
	Next
	$hTimer = Round(TimerDiff($hTimer)) ; End the timer and find the difference from start to finish.

	ReDim $aArray[$aArray[0] + 1] ; Remove the empty elements by ReDimming the total count plus the element for holding the count.

	MsgBox($MB_SYSTEMMODAL, "How many times?", "The amount of times a " & $iArrayTotal & " element array was ""ReDimmed"" was " & $iCount & " times." & @CRLF & _
			"It only took " & $hTimer & " milliseconds to complete.")
	; If using the method of increasing the array size by 1, $iCount would return 5000, not 29 as demonstrated in this example.
EndFunc   ;==>Example

; ReDim when required by increasing the total array size as totalsize * 1.3 and rounding to the next highest integer.
Func ReDim1D(ByRef $aArray, ByRef $iDimension) ; Where zeroth index [0] is the element count.
	Local $bReturn = False
	If ($aArray[0] + 1) >= $iDimension Then
		$bReturn = True
		$iDimension = Ceiling(($aArray[0] + 1) * 1.3)
		ReDim $aArray[$iDimension]
	EndIf
	Return $bReturn
EndFunc   ;==>ReDim1D
