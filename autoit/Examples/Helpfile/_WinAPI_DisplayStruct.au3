#include <WinAPIDiag.au3>

Local $sStruct = 'dword Length;short State;uint Flags;handle hBitmap;hwnd hDC;long Rect[4];byte[14];int Reserved[10];wchar Text[80]'
Local $tStruct = DllStructCreate($sStruct)

DllStructSetData($tStruct, 1, 80)
DllStructSetData($tStruct, 2, 6)
DllStructSetData($tStruct, 3, 1)
DllStructSetData($tStruct, 4, 0x00010014)
DllStructSetData($tStruct, 5, 0x01010057)
DllStructSetData($tStruct, 6, 20, 1)
DllStructSetData($tStruct, 6, 20, 2)
DllStructSetData($tStruct, 6, 60, 3)
DllStructSetData($tStruct, 6, 80, 4)
DllStructSetData($tStruct, 7, Binary('0x656A6D633835206C6A6764206200'))
DllStructSetData($tStruct, 8, 0)
DllStructSetData($tStruct, 9, 'Simple Text')

_WinAPI_DisplayStruct($tStruct, $sStruct)
