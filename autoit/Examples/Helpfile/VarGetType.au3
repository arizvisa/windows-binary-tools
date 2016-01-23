#include <MsgBoxConstants.au3>

Local $aArray[2] = [1, "Example"]
Local $mMap[]
Local $dBinary = Binary("0x00204060")
Local $bBoolean = False
Local $pPtr = Ptr(-1)
Local $hWnd = WinGetHandle(AutoItWinGetTitle())
Local $iInt = 1
Local $fFloat = 2.0
Local $oObject = ObjCreate("Scripting.Dictionary")
Local $sString = "Some text"
Local $tStruct = DllStructCreate("wchar[256]")
Local $vKeyword = Default
Local $fuFunc = ConsoleWrite
Local $fuUserFunc = Test

MsgBox($MB_SYSTEMMODAL, "", _
		"Variable Types" & @CRLF & @CRLF & _
		"$aArray : " & @TAB & @TAB & VarGetType($aArray) & " variable type." & @CRLF & _
		"$mMap : " & @TAB & @TAB & VarGetType($mMap) & " variable type." & @CRLF & _
		"$dBinary : " & @TAB & @TAB & VarGetType($dBinary) & " variable type." & @CRLF & _
		"$bBoolean : " & @TAB & VarGetType($bBoolean) & " variable type." & @CRLF & _
		"$pPtr : " & @TAB & @TAB & VarGetType($pPtr) & " variable type." & @CRLF & _
		"$hWnd : " & @TAB & @TAB & VarGetType($hWnd) & " variable type." & @CRLF & _
		"$iInt : " & @TAB & @TAB & VarGetType($iInt) & " variable type." & @CRLF & _
		"$fFloat : " & @TAB & @TAB & VarGetType($fFloat) & " variable type." & @CRLF & _
		"$oObject : " & @TAB & VarGetType($oObject) & " variable type." & @CRLF & _
		"$sString : " & @TAB & @TAB & VarGetType($sString) & " variable type." & @CRLF & _
		"$tStruct : " & @TAB & @TAB & VarGetType($tStruct) & " variable type." & @CRLF & _
		"$vKeyword : " & @TAB & VarGetType($vKeyword) & " variable type." & @CRLF & _
		"MsgBox : " & @TAB & @TAB & VarGetType(MsgBox) & " variable type." & @CRLF & _
		"$fuFunc : " & @TAB & @TAB & VarGetType($fuFunc) & " variable type." & @CRLF & _
		"Func 'Test' : " & @TAB & VarGetType(Test) & " variable type." & @CRLF & _
		"$fuUserFunc : " & @TAB & VarGetType($fuUserFunc) & " variable type.")

Func Test()
EndFunc   ;==>Test
