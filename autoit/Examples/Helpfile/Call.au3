#include <MsgBoxConstants.au3>

Example()

Func Example()
	; This calls a function accepting no arguments.
	Call("Test1")

	; This calls a function accepting one argument and passes it an argument.
	Call("Test2", "Message from Call()!")

	; This demonstrates how to use the special array argument.
	Local $aArgs[4]
	$aArgs[0] = "CallArgArray" ; This is required, otherwise, Call() will not recognize the array as containing arguments
	$aArgs[1] = "This is a string" ; Parameter one is a string
	$aArgs[2] = 47 ; Parameter two is a number
	Local $aArray[2]
	$aArray[0] = "Array Element 0"
	$aArray[1] = "Array Element 1"
	$aArgs[3] = $aArray ; Parameter three is an array

	; We've built the special array, now call the function
	Call("Test3", $aArgs)

	; Test calling a function that does not exist.  This shows the proper way to test by
	; checking that both @error and @extended contain the documented failure values.
	Local Const $sFunction = "DoesNotExist"
	Call($sFunction)
	If @error = 0xDEAD And @extended = 0xBEEF Then MsgBox($MB_SYSTEMMODAL, "", "Function does not exist.")
EndFunc   ;==>Example

Func Test1()
	MsgBox($MB_SYSTEMMODAL, "", "Hello")
EndFunc   ;==>Test1

Func Test2($sMsg)
	MsgBox($MB_SYSTEMMODAL, "", $sMsg)
EndFunc   ;==>Test2

Func Test3($sString, $nNumber, $aArray)
	MsgBox($MB_SYSTEMMODAL, "", "The string is: " & @CRLF & $sString)
	MsgBox($MB_SYSTEMMODAL, "", "The number is: " & @CRLF & $nNumber)
	For $i = 0 To UBound($aArray) - 1
		MsgBox($MB_SYSTEMMODAL, "", "Array[" & $i & "] contains:" & @CRLF & $aArray[$i])
	Next
EndFunc   ;==>Test3
