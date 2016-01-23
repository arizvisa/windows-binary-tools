Global $__g_oTemplateCOMErrorHandler = 0

Local $oShell = ObjCreate("Shell.Application")

; Wrap calls that are likely to fatal error

; This won't fatal error, it will set @error as in 3.3.11.0
Template_COMErrorRegister()
$oShell.InvalidFunction()
If @error Then MsgBox(4096, "COM Error Detected", @error)
Template_COMErrorUnregister()

; This will fatal error, the 2nd line will not be reached.
$oShell.InvalidFunction()
If @error Then MsgBox(4096, "COM Error Detected", @error)

Func Template_COMErrorRegister()
	$__g_oTemplateCOMErrorHandler = ObjEvent("AutoIt.Error", "Template_COMErrFunc")
EndFunc   ;==>Template_COMErrorRegister

Func Template_COMErrorUnregister()
	$__g_oTemplateCOMErrorHandler = 0
EndFunc   ;==>Template_COMErrorUnregister

Func Template_COMErrFunc()
	; Do nothing special, just check @error after suspect functions.
EndFunc   ;==>Template_COMErrFunc
