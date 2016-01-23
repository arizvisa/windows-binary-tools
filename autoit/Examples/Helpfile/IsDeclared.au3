#include <MsgBoxConstants.au3>

; Check if the variable $vVar is declared. As the variable isn't will display the error message.
If Not IsDeclared("vVar") Then
	MsgBox($MB_SYSTEMMODAL, "", "The variable $vVar is not declared.")

	Local $vVar = 0 ; Initialize the variable $vVar with data.
	If IsDeclared("vVar") Then ; Check if the variable $vVar is declared.
		MsgBox($MB_SYSTEMMODAL, "", "The variable $vVar is declared.")
	Else
		MsgBox($MB_SYSTEMMODAL, "", "The variable $vVar is not declared.")
	EndIf
EndIf
