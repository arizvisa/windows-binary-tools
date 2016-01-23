#AutoIt3Wrapper_Au3Check_Parameters=-q -d -w- 3 -w- 6 ; Already declared var=off, warn when using Dim=off

#include <MsgBoxConstants.au3>

Dim $vVariableThatIsGlobal = "This is a variable that has ""Program Scope"" aka Global."

MsgBox($MB_SYSTEMMODAL, "", "An example of why Dim can cause more problems than solve them.")

Example()

Func Example()
	; That looks alright to me as it displays the following text: This is a variable that has "Program Scope" aka Global.
	MsgBox($MB_SYSTEMMODAL, "", $vVariableThatIsGlobal)

	; Call some random function.
	Local $vReturn = SomeFunc()

	; The Global variable ($vVariableThatIsGlobal) changed because I totally forgot I had a duplicate variable name in "SomeFunc".
	MsgBox($MB_SYSTEMMODAL, $vReturn, "The variable has now changed: " & $vVariableThatIsGlobal)
EndFunc   ;==>Example

Func SomeFunc()
	; This should create a variable in Local scope if the variable name doesn't already exist.
	; For argument sake I totally forgot that I declared a variable already with the same name.
	; Well I only want this to be changed in the function and not the variable at the top of the script.
	; Should be OK right? Think again.
	Dim $vVariableThatIsGlobal = ""

	For $i = 1 To 10
		$vVariableThatIsGlobal &= $i ; This will return 12345678910 totally wiping the previous contents of $vVariableThatIsGlobal.
	Next
	Return $vVariableThatIsGlobal
EndFunc   ;==>SomeFunc
