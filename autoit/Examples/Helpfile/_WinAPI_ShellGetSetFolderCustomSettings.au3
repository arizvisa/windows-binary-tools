#include <APIShellExConstants.au3>
#include <WinAPIDlg.au3>
#include <WinAPIShellEx.au3>

; Select folder
Local $sPath = FileSelectFolder('Select Folder', '', 0, @ScriptDir)
If Not $sPath Then
	Exit
EndIf

; Select icon
Local $aIcon = _WinAPI_PickIconDlg()
If @error Then Exit

; Set icon to selected folder
Local $tSHFCS = DllStructCreate($tagSHFOLDERCUSTOMSETTINGS & ';wchar szIconFile[' & (StringLen($aIcon[0]) + 1) & ']')
DllStructSetData($tSHFCS, 'Size', DllStructGetPtr($tSHFCS, 'szIconFile') - DllStructGetPtr($tSHFCS))
DllStructSetData($tSHFCS, 'Mask', $FCSM_ICONFILE)
DllStructSetData($tSHFCS, 'IconFile', DllStructGetPtr($tSHFCS, 'szIconFile'))
DllStructSetData($tSHFCS, 'SizeIF', 260)
DllStructSetData($tSHFCS, 'IconIndex', $aIcon[1])
DllStructSetData($tSHFCS, 'szIconFile', $aIcon[0])

_WinAPI_ShellGetSetFolderCustomSettings($sPath, $FCS_FORCEWRITE, $tSHFCS)
