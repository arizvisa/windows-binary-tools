#include <MsgBoxConstants.au3>

Example()

Func Example()
	SomeFunc() ; This will display a message box of 1, 1.
	SomeFunc() ; This will display a message box of 1, 2.
	SomeFunc() ; This will display a message box of 1, 3.
EndFunc   ;==>Example

Func SomeFunc()
	; This initialises a Static variable in Local scope. When a variable is declared just in Local scope (within a Function,)
	; it's destroyed when the Function ends/returns. This isn't the case for a Static variable. The variable can't be
	; accessed from anywhere else in the script apart from the Function it was declared in.
	Local Static $vVariableThatIsStatic = 0
	Local $vVariableThatIsLocal = 0
	$vVariableThatIsLocal += 1 ; This will always be 1 as it was destroyed once returned from SomeFunc.
	$vVariableThatIsStatic += 1 ; This will increase by 1.
	MsgBox($MB_SYSTEMMODAL, $vVariableThatIsLocal, $vVariableThatIsStatic)
EndFunc   ;==>SomeFunc
