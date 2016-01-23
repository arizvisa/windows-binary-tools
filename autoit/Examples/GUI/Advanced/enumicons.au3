; ===============================================================================
;
; Description:      Show all icons in the given file
; Requirement(s):   AutoIt 3.0.103+
; Author(s):        YDY (Lazycat)
;
; ===============================================================================

#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>

; Setting variables
Global $g_aidIcons[30], $g_aidLabels[30]
Global $g_iStartIndex = 1
Global $g_sFilename = @SystemDir & "\shell32.dll"; Default file is "shell32.dll"
Global $g_iOrdinal = -1

Global $g_idPrev

_Main()

Func _Main()
	Local $iMsg, $sCurFilename, $sTmpFile

	; Creating GUI and controls
	Local $hGui = GUICreate("Icon Selector by Ordinal value", 385, 435, @DesktopWidth / 2 - 192, _
			@DesktopHeight / 2 - 235, -1, $WS_EX_ACCEPTFILES)
	GUICtrlCreateGroup("", 5, 1, 375, 40)
	GUICtrlCreateGroup("", 5, 50, 375, 380)
	Local $idFile = GUICtrlCreateInput($g_sFilename, 12, 15, 325, 16, -1, $WS_EX_STATICEDGE)
	GUICtrlSetState(-1, $GUI_DROPACCEPTED)
	GUICtrlSetTip(-1, "You can drop files from shell here...")
	Local $idFileSel = GUICtrlCreateButton("...", 345, 14, 26, 18)
	$g_idPrev = GUICtrlCreateButton("Previous", 10, 45, 60, 24, $BS_FLAT)
	GUICtrlSetState(-1, $GUI_DISABLE)
	Local $idNext = GUICtrlCreateButton("Next", 75, 45, 60, 24, $BS_FLAT)
	Local $idToggle = GUICtrlCreateButton("by Name", 300, 45, 60, 24, $BS_FLAT)

	; This code build two arrays of ID's of icons and labels for easily update
	Local $iCurIndex
	For $iCntRow = 0 To 4
		For $iCntCol = 0 To 5
			$iCurIndex = $iCntRow * 6 + $iCntCol
			$g_aidIcons[$iCurIndex] = GUICtrlCreateIcon($g_sFilename, $g_iOrdinal * ($iCurIndex + 1), _
					60 * $iCntCol + 25, 70 * $iCntRow + 80)
			$g_aidLabels[$iCurIndex] = GUICtrlCreateLabel($g_iOrdinal * ($iCurIndex + 1), _
					60 * $iCntCol + 11, 70 * $iCntRow + 115, 60, 20, $SS_CENTER)
		Next
	Next

	GUISetState()

	While 1
		$iMsg = GUIGetMsg()
		; Code below will check if the file is dropped (or selected)
		$sCurFilename = GUICtrlRead($idFile)
		If $sCurFilename <> $g_sFilename Then
			$g_iStartIndex = 1
			$g_sFilename = $sCurFilename
			_GUIUpdate()
		EndIf
		; Main "Select" statement that handles other events
		Select
			Case $iMsg = $idFileSel
				$sTmpFile = FileOpenDialog("Select file:", "::{20D04FE0-3AEA-1069-A2D8-08002B30309D}", "Executables & dll's (*.exe;*.dll;*.ocx;*.icl)")
				If @error Then ContinueLoop
				GUICtrlSetData($idFile, $sTmpFile); GUI will be updated at next iteration
			Case $iMsg = $g_idPrev
				$g_iStartIndex = $g_iStartIndex - 30
				_GUIUpdate()
			Case $iMsg = $idNext
				$g_iStartIndex = $g_iStartIndex + 30
				_GUIUpdate()
			Case $iMsg = $idToggle
				If $g_iOrdinal = -1 Then
					$g_iOrdinal = 1
					GUICtrlSetData($idToggle, "by Ordinal")
					WinSetTitle($hGui, "", "Icon Selector by Name value")
				Else
					$g_iOrdinal = -1
					GUICtrlSetData($idToggle, "by Name")
					WinSetTitle($hGui, "", "Icon Selector by Ordinal value")
				EndIf
				_GUIUpdate()
			Case $iMsg = $GUI_EVENT_CLOSE
				Exit
		EndSelect
	WEnd
EndFunc   ;==>_Main

; Just updates GUI icons, labels and set state of "Previous" button
Func _GUIUpdate()
	Local $iCurIndex
	For $iCntRow = 0 To 4
		For $iCntCol = 0 To 5
			$iCurIndex = $iCntRow * 6 + $iCntCol
			GUICtrlSetImage($g_aidIcons[$iCurIndex], $g_sFilename, $g_iOrdinal * ($iCurIndex + $g_iStartIndex))
			If $g_iOrdinal = -1 Then
				GUICtrlSetData($g_aidLabels[$iCurIndex], -($iCurIndex + $g_iStartIndex))
			Else
				GUICtrlSetData($g_aidLabels[$iCurIndex], '"' & ($iCurIndex + $g_iStartIndex) & '"')
			EndIf
		Next
	Next
	; This is because we don't want negative values
	If $g_iStartIndex = 1 Then
		GUICtrlSetState($g_idPrev, $GUI_DISABLE)
	Else
		GUICtrlSetState($g_idPrev, $GUI_ENABLE)
	EndIf
EndFunc   ;==>_GUIUpdate
