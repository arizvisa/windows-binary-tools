#include <APIDlgConstants.au3>
#include <Memory.au3>
#include <WinAPIDlg.au3>
#include <WinAPIFiles.au3>

Opt('WinTitleMatchMode', 3)

; Create PRINTDLGEX structure and set initial values for the number of copies, starting, and ending page
Local $tPRINTPAGERANGE = DllStructCreate($tagPRINTPAGERANGE)
DllStructSetData($tPRINTPAGERANGE, 'FromPage', 2)
DllStructSetData($tPRINTPAGERANGE, 'ToPage', 3)
Local $tPRINTDLGEX = DllStructCreate($tagPRINTDLGEX)
DllStructSetData($tPRINTDLGEX, 'Size', DllStructGetSize($tPRINTDLGEX))
DllStructSetData($tPRINTDLGEX, 'hOwner', WinGetHandle(AutoItWinGetTitle()))
DllStructSetData($tPRINTDLGEX, 'Flags', BitOR($PD_PAGENUMS, $PD_NOCURRENTPAGE, $PD_NOSELECTION))
DllStructSetData($tPRINTDLGEX, 'NumPageRanges', 1)
DllStructSetData($tPRINTDLGEX, 'MaxPageRanges', 1)
DllStructSetData($tPRINTDLGEX, 'PageRanges', DllStructGetPtr($tPRINTPAGERANGE))
DllStructSetData($tPRINTDLGEX, 'MinPage', 1)
DllStructSetData($tPRINTDLGEX, 'MaxPage', 9)
DllStructSetData($tPRINTDLGEX, 'Copies', 4)
DllStructSetData($tPRINTDLGEX, 'StartPage', -1)

; Display Print property sheet
If Not _WinAPI_PrintDlgEx($tPRINTDLGEX) Then
	Exit
EndIf

Switch @extended
	Case $PD_RESULT_PRINT
		; The user clicked the "Print" button
	Case $PD_RESULT_APPLY
		; The user clicked the "Apply" button and later clicked the "Cancel" button
	Case $PD_RESULT_CANCEL
		Exit
EndSwitch

; Show results
Local $hDevNames = DllStructGetData($tPRINTDLGEX, 'hDevNames')
Local $pDevNames = _MemGlobalLock($hDevNames)
Local $tDEVNAMES = DllStructCreate($tagDEVNAMES, $pDevNames)
ConsoleWrite('Printer: ' & _WinAPI_GetString($pDevNames + 2 * DllStructGetData($tDEVNAMES, 'DeviceOffset')))
If DllStructGetData($tDEVNAMES, 'Default') Then
	ConsoleWrite(' (Default)' & @CRLF)
Else
	ConsoleWrite(@CRLF)
EndIf
Local $aPage[2]
If BitAND(DllStructGetData($tPRINTDLGEX, 'Flags'), $PD_PAGENUMS) Then
	$aPage[0] = DllStructGetData($tPRINTPAGERANGE, 'FromPage')
	$aPage[1] = DllStructGetData($tPRINTPAGERANGE, 'ToPage')
Else
	$aPage[0] = DllStructGetData($tPRINTDLGEX, 'MinPage')
	$aPage[1] = DllStructGetData($tPRINTDLGEX, 'MaxPage')
EndIf
ConsoleWrite('First page: ' & $aPage[0] & @CRLF)
ConsoleWrite('Last page: ' & $aPage[1] & @CRLF)
ConsoleWrite('Copies: ' & DllStructGetData($tPRINTDLGEX, 'Copies') & @CRLF)

; Free global memory objects that contains a DEVMODE and DEVNAMES structures
_MemGlobalFree(DllStructGetData($tPRINTDLGEX, 'hDevMode'))
_MemGlobalFree($hDevNames)
