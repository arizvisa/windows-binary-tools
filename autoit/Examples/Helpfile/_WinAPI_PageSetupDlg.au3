#include <APIDlgConstants.au3>
#include <Memory.au3>
#include <WinAPIDlg.au3>

; Create PAGESETUPDLG structure and set initial margin values for 10.00 mm at all
Local $tPAGESETUPDLG = DllStructCreate($tagPAGESETUPDLG)
DllStructSetData($tPAGESETUPDLG, 'Size', DllStructGetSize($tPAGESETUPDLG))
DllStructSetData($tPAGESETUPDLG, 'Flags', BitOR($PSD_INHUNDREDTHSOFMILLIMETERS, $PSD_MARGINS))
DllStructSetData($tPAGESETUPDLG, 'MarginLeft', 10 * 100)
DllStructSetData($tPAGESETUPDLG, 'MarginTop', 10 * 100)
DllStructSetData($tPAGESETUPDLG, 'MarginRight', 10 * 100)
DllStructSetData($tPAGESETUPDLG, 'MarginBottom', 10 * 100)

; Create Page Setup dialog box
If Not _WinAPI_PageSetupDlg($tPAGESETUPDLG) Then
	Exit
EndIf

; Show results
ConsoleWrite('Paper width: ' & DllStructGetData($tPAGESETUPDLG, 'PaperWidth') / 100 & ' mm' & @CRLF)
ConsoleWrite('Paper height: ' & DllStructGetData($tPAGESETUPDLG, 'PaperHeight') / 100 & ' mm' & @CRLF)
ConsoleWrite('Margin left: ' & DllStructGetData($tPAGESETUPDLG, 'MarginLeft') / 100 & ' mm' & @CRLF)
ConsoleWrite('Margin top: ' & DllStructGetData($tPAGESETUPDLG, 'MarginTop') / 100 & ' mm' & @CRLF)
ConsoleWrite('Margin right: ' & DllStructGetData($tPAGESETUPDLG, 'MarginRight') / 100 & ' mm' & @CRLF)
ConsoleWrite('Margin bottom: ' & DllStructGetData($tPAGESETUPDLG, 'MarginBottom') / 100 & ' mm' & @CRLF)

; Free global memory objects that contains a DEVMODE and DEVNAMES structures
_MemGlobalFree(DllStructGetData($tPAGESETUPDLG, 'hDevMode'))
_MemGlobalFree(DllStructGetData($tPAGESETUPDLG, 'hDevNames'))
