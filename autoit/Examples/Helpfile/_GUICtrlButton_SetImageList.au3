#include <GuiButton.au3>
#include <GUIConstantsEx.au3>
#include <GuiImageList.au3>

Example()

Func Example()
	Local $hImage, $y = 70, $iIcon = 125, $a_idBtn[6], $a_idRdo[6], $a_idChk[6], $hImageSmall

	GUICreate("Buttons", 510, 400)
	GUISetState(@SW_SHOW)

	$hImage = _GUIImageList_Create(32, 32, 5, 3, 6)
	For $x = 6 To 11
		_GUIImageList_AddIcon($hImage, "shell32.dll", $x, True)
	Next

	$hImageSmall = _GUIImageList_Create(16, 16, 5, 3, 6)
	For $x = 6 To 11
		_GUIImageList_AddIcon($hImageSmall, "shell32.dll", $x)
	Next

	$a_idBtn[0] = GUICtrlCreateButton("Button1", 10, 10, 90, 50)
	_GUICtrlButton_SetImageList($a_idBtn[0], $hImage)

	$a_idRdo[0] = GUICtrlCreateRadio("Radio Button1", 120, 10, 120, 25)
	_GUICtrlButton_SetImageList($a_idRdo[0], $hImageSmall)

	$a_idChk[0] = GUICtrlCreateCheckbox("Check Button1", 260, 10, 120, 25)
	_GUICtrlButton_SetImageList($a_idChk[0], $hImageSmall)

	For $x = 1 To 5
		$a_idBtn[$x] = GUICtrlCreateButton("Button" & $x + 1, 10, $y, 90, 50)
		_GUICtrlButton_SetImageList($a_idBtn[$x], _GetImageListHandle("shell32.dll", $iIcon + $x, True), $x)
		$a_idRdo[$x] = GUICtrlCreateRadio("Radio Button" & $x + 1, 120, $y, 120, 25)
		_GUICtrlButton_SetImageList($a_idRdo[$x], _GetImageListHandle("shell32.dll", $iIcon + $x), $x)
		$a_idChk[$x] = GUICtrlCreateCheckbox("Check Button" & $x + 1, 260, $y, 120, 25)
		_GUICtrlButton_SetImageList($a_idChk[$x], _GetImageListHandle("shell32.dll", $iIcon + $x), $x)
		$y += 60
	Next

	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				ExitLoop
		EndSwitch
	WEnd

	Exit
EndFunc   ;==>Example

; using image list to set 1 image and have text on button
Func _GetImageListHandle($sFile, $nIconID = 0, $bLarge = False)
	Local $iSize = 16
	If $bLarge Then $iSize = 32

	Local $hImage = _GUIImageList_Create($iSize, $iSize, 5, 3)
	If StringUpper(StringMid($sFile, StringLen($sFile) - 2)) = "BMP" Then
		_GUIImageList_AddBitmap($hImage, $sFile)
	Else
		_GUIImageList_AddIcon($hImage, $sFile, $nIconID, $bLarge)
	EndIf
	Return $hImage
EndFunc   ;==>_GetImageListHandle
