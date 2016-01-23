#include <MsgBoxConstants.au3>

Example()

Func Example()
	; Create variables in Local scope and enumerate through the variables. Default is to start from 0.
	Local Enum $eCat, $eDog, $eMouse, $eHamster ; $eHamster is equal to the value 3, not 4.

	; Create an array in Local scope with 4 elements.
	Local $aAnimalNames[4]

	; Assign each array element with the name of the respective animal. For example the name of the cat is Jasper.
	$aAnimalNames[$eCat] = 'Jasper' ; $eCat is equal to 0, similar to using $aAnimalNames[0]
	$aAnimalNames[$eDog] = 'Beethoven' ; $eDog is equal to 1, similar to using $aAnimalNames[1]
	$aAnimalNames[$eMouse] = 'Pinky' ; $eMouse is equal to 2, similar to using $aAnimalNames[2]
	$aAnimalNames[$eHamster] = 'Fidget' ; $eHamster is equal to 3, similar to using $aAnimalNames[3]

	; Display the values of the array.
	MsgBox($MB_SYSTEMMODAL, '', '$aAnimalNames[$eCat] = ' & $aAnimalNames[$eCat] & @CRLF & _
			'$aAnimalNames[$eDog] = ' & $aAnimalNames[$eDog] & @CRLF & _
			'$aAnimalNames[$eMouse] = ' & $aAnimalNames[$eMouse] & @CRLF & _
			'$aAnimalNames[$eHamster] = ' & $aAnimalNames[$eHamster] & @CRLF)

	; Sometimes using this approach for accessing an element is more practical than using a numerical value, due to the fact that changing the index value of
	; the enum constant has no affect on it's position in the array. Therefore changing the location of $eCat in the array is as simple as changing the order
	; it appears in the initial declaration e.g.

	; Local Enum $eDog, $eMouse, $eCat, $eHamster

	; Now $eCat is the 2nd element in the array. If you were using numerical values, you would have to manually change all references of $aAnimalNames[0] to
	; $aAnimalNames[2], as well as for the other elements which have now shifted.
EndFunc   ;==>Example
