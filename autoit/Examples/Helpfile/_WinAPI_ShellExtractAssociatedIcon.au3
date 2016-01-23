#include <GUIConstantsEx.au3>
#include <GUIImageList.au3>
#include <GUIListView.au3>
#include <WinAPIShellEx.au3>
#include <WindowsConstants.au3>

Local $hIcon, $sKey, $iCount = 1, $bFirst = False
Local $tSHFILEINFO = DllStructCreate($tagSHFILEINFO)
Local $aExt[101] = [0]

RegRead('HKCR\.x', '')

While 1
	$sKey = RegEnumKey('HKCR', $iCount)
	If @error Then
		ExitLoop
	EndIf
	If StringLeft($sKey, 1) = '.' Then
		RegRead('HKCR\' & $sKey, '')
		If Abs(@error) <> 1 Then
			$aExt[0] += 1
			If $aExt[0] > UBound($aExt) - 1 Then
				ReDim $aExt[UBound($aExt) + 100]
			EndIf
			$aExt[$aExt[0]] = $sKey
		EndIf
		$bFirst = True
	Else
		If $bFirst Then
			ExitLoop
		EndIf
	EndIf
	$iCount += 1
WEnd

Local $hForm = GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), 280, 391)

Local $idListview = GUICtrlCreateListView('', 10, 10, 260, 344, BitOR($LVS_DEFAULT, $LVS_NOCOLUMNHEADER), $WS_EX_CLIENTEDGE)
_GUICtrlListView_SetExtendedListViewStyle($idListview, BitOR($LVS_EX_DOUBLEBUFFER, $LVS_EX_INFOTIP))
_GUICtrlListView_InsertColumn($idListview, 0, '', 238)
Local $hImageList = _GUIImageList_Create(16, 16, 5, 1)
_GUICtrlListView_SetImageList($idListview, $hImageList, 1)
Local $idButton = GUICtrlCreateButton('OK', 105, 361, 70, 23)

For $i = 1 To $aExt[0]
	$hIcon = _WinAPI_ShellExtractAssociatedIcon($aExt[$i], 1)
	_GUIImageList_ReplaceIcon($hImageList, -1, $hIcon)
	_GUICtrlListView_AddItem($idListview, $aExt[$i], $i - 1)
	_WinAPI_DestroyIcon($hIcon)
Next

GUISetState(@SW_SHOW)

While 1
	Switch GUIGetMsg()
		Case $GUI_EVENT_CLOSE, $idButton
			ExitLoop
	EndSwitch
WEnd
