#include <Constants.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	; Check if a variable is the Default keyword.
	Local $vDefault = Default
	If IsDefault($vDefault) Then
		MsgBox($MB_SYSTEMMODAL, "", "The variable is the Default keyword")
	Else
		MsgBox($MB_SYSTEMMODAL, "", "The variable is not the Default keyword")
	EndIf

	; Check if a variable is the Null keyword.
	Local $vNull = Null
	If IsNull($vNull) Then
		MsgBox($MB_SYSTEMMODAL, "", "The variable is the Null keyword")
	Else
		MsgBox($MB_SYSTEMMODAL, "", "The variable is not the Null keyword")
	EndIf

	; Check if a variable is the Null keyword. This will be false as $sString is a string datatype.
	Local $sString = 'Default'
	If IsDefault($sString) Then
		MsgBox($MB_SYSTEMMODAL, "", "The variable is the Default keyword")
	Else
		MsgBox($MB_SYSTEMMODAL, "", "The variable is not the Default keyword")
	EndIf
EndFunc   ;==>Example

Func IsDefault($vKeyword)
	Return IsKeyword($vKeyword) = $KEYWORD_DEFAULT
EndFunc   ;==>IsDefault

Func IsNull($vKeyword)
	Return IsKeyword($vKeyword) = $KEYWORD_NULL
EndFunc   ;==>IsNull
