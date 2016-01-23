#include <Crypt.au3>
#include <MsgBoxConstants.au3>

Example()

Func Example()
	; Generate 16 bytes of random data
	Local $tBuff = DllStructCreate("byte[16]")
	_Crypt_GenRandom($tBuff, DllStructGetSize($tBuff))
	MsgBox($MB_SYSTEMMODAL, "Random data:", DllStructGetData($tBuff, 1))
EndFunc   ;==>Example
