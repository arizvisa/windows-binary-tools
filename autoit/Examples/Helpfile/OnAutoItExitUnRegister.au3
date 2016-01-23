#include <MsgBoxConstants.au3>

OnAutoItExitRegister("MyTestFunc")
OnAutoItExitRegister("MyTestFunc2")

Sleep(1000)

OnAutoItExitUnRegister("MyTestFunc")

Func MyTestFunc()
	MsgBox($MB_SYSTEMMODAL, "Exit Results 1", 'Exit Message from MyTestFunc()')
EndFunc   ;==>MyTestFunc

Func MyTestFunc2()
	MsgBox($MB_SYSTEMMODAL, "Exit Results 2", 'Exit Message from MyTestFunc()')
EndFunc   ;==>MyTestFunc2
