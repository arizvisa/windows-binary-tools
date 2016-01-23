#include <APIDlgConstants.au3>
#include <Memory.au3>
#include <WinAPIDlg.au3>
#include <WinAPIFiles.au3>

; Create PRINTDLG structure and set initial values for the number of copies, starting, and ending page
Local $tPRINTDLG = DllStructCreate($tagPRINTDLG)
DllStructSetData($tPRINTDLG, 'Size', DllStructGetSize($tPRINTDLG))
DllStructSetData($tPRINTDLG, 'Flags', $PD_PAGENUMS)
DllStructSetData($tPRINTDLG, 'FromPage', 2)
DllStructSetData($tPRINTDLG, 'ToPage', 3)
DllStructSetData($tPRINTDLG, 'MinPage', 1)
DllStructSetData($tPRINTDLG, 'MaxPage', 9)
DllStructSetData($tPRINTDLG, 'Copies', 4)

; Create Print dialog box

If Not _WinAPI_PrintDlg($tPRINTDLG) Then
	Exit
EndIf

; Show results
Local $hDevNames = DllStructGetData($tPRINTDLG, 'hDevNames')
Local $pDevNames = _MemGlobalLock($hDevNames)
Local $tDEVNAMES = DllStructCreate($tagDEVNAMES, $pDevNames)
ConsoleWrite('Printer: ' & _WinAPI_GetString($pDevNames + 2 * DllStructGetData($tDEVNAMES, 'DeviceOffset')))
If DllStructGetData($tDEVNAMES, 'Default') Then
	ConsoleWrite(' (Default)' & @CRLF)
Else
	ConsoleWrite(@CRLF)
EndIf
ConsoleWrite('First page: ' & DllStructGetData($tPRINTDLG, 'FromPage') & @CRLF)
ConsoleWrite('Last page: ' & DllStructGetData($tPRINTDLG, 'ToPage') & @CRLF)
ConsoleWrite('Copies: ' & DllStructGetData($tPRINTDLG, 'Copies') & @CRLF)

; Free global memory objects that contains a DEVMODE and DEVNAMES structures
_MemGlobalFree(DllStructGetData($tPRINTDLG, 'hDevMode'))
_MemGlobalFree($hDevNames)
