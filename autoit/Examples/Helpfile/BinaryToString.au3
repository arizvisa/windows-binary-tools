#include <MsgBoxConstants.au3>
#include <StringConstants.au3>

Example()

Func Example()
	; Define the string that will be converted later.
	; NOTE: This string may show up as ?? in the help file and even in some editors.
	; This example is saved as UTF-8 with BOM.  It should display correctly in editors
	; which support changing code pages based on BOMs.
	Local Const $sString = "Hello - 你好"

	; Temporary variables used to store conversion results.  $dBinary will hold
	; the original string in binary form and $sConverted will hold the result
	; afte it's been transformed back to the original format.
	Local $dBinary = Binary(""), $sConverted = ""

	; Convert the original UTF-8 string to an ANSI compatible binary string.
	$dBinary = StringToBinary($sString)

	; Convert the ANSI compatible binary string back into a string.
	$sConverted = BinaryToString($dBinary)

	; Display the resulsts.  Note that the last two characters will appear
	; as ?? since they cannot be represented in ANSI.
	DisplayResults($sString, $dBinary, $sConverted, "ANSI")

	; Convert the original UTF-8 string to an UTF16-LE binary string.
	$dBinary = StringToBinary($sString, $SB_UTF16LE)

	; Convert the UTF16-LE binary string back into a string.
	$sConverted = BinaryToString($dBinary, $SB_UTF16LE)

	; Display the resulsts.
	DisplayResults($sString, $dBinary, $sConverted, "UTF16-LE")

	; Convert the original UTF-8 string to an UTF16-BE binary string.
	$dBinary = StringToBinary($sString, $SB_UTF16BE)

	; Convert the UTF16-BE binary string back into a string.
	$sConverted = BinaryToString($dBinary, $SB_UTF16BE)

	; Display the resulsts.
	DisplayResults($sString, $dBinary, $sConverted, "UTF16-BE")

	; Convert the original UTF-8 string to an UTF-8 binary string.
	$dBinary = StringToBinary($sString, $SB_UTF8)

	; Convert the UTF8 binary string back into a string.
	$sConverted = BinaryToString($dBinary, $SB_UTF8)

	; Display the resulsts.
	DisplayResults($sString, $dBinary, $sConverted, "UTF8")
EndFunc   ;==>Example

; Helper function which formats the message for display.  It takes the following parameters:
; $sOriginal - The original string before conversions.
; $dBinary - The original string after it has been converted to binary.
; $sConverted- The string after it has been converted to binary and then back to a string.
; $sConversionType - A human friendly name for the encoding type used for the conversion.
Func DisplayResults($sOriginal, $dBinary, $sConverted, $sConversionType)
	MsgBox($MB_SYSTEMMODAL, "", "Original:" & @CRLF & $sOriginal & @CRLF & @CRLF & "Binary:" & @CRLF & $dBinary & @CRLF & @CRLF & $sConversionType & ":" & @CRLF & $sConverted)
EndFunc   ;==>DisplayResults
