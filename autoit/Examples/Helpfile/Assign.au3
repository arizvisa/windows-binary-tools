#include <MsgBoxConstants.au3>

; Assign the variable string sString with data.
Assign("sString", "This is a string which is declared using the function Assign")

; Find the value of the variable string sString and assign to the variable $sEvalString.
Local $sEvalString = Eval("sString")

; Display the value of $sEvalString. This should be the same value as $sString.
MsgBox($MB_SYSTEMMODAL, "", $sEvalString)
