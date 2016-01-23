#include <GUIConstantsEx.au3>
#include <GuiImageList.au3>
#include <GuiTreeView.au3>
#include <WinAPI.au3>
#include <WindowsConstants.au3>

Example()

Func Example()
	Local $hGUI, $hImage, $iImage, $hItem, $bDragging = False, $aDrag, $idTreeView
	Local $iStyle = BitOR($TVS_EDITLABELS, $TVS_HASBUTTONS, $TVS_HASLINES, $TVS_LINESATROOT, $TVS_SHOWSELALWAYS, $TVS_CHECKBOXES)

	$hGUI = GUICreate("TreeView Create Drage Image", 400, 300)
	$idTreeView = GUICtrlGetHandle(GUICtrlCreateTreeView(2, 2, 396, 268, $iStyle, $WS_EX_CLIENTEDGE))

	GUISetState(@SW_SHOW)

	; Load images
	$hImage = _GUIImageList_Create(16, 16, 5, 3)
	_GUIImageList_AddIcon($hImage, "shell32.dll", 110)
	_GUIImageList_AddIcon($hImage, "shell32.dll", 131)
	_GUIImageList_AddIcon($hImage, "shell32.dll", 165)
	_GUIImageList_AddIcon($hImage, "shell32.dll", 168)
	_GUIImageList_AddIcon($hImage, "shell32.dll", 137)
	_GUIImageList_AddIcon($hImage, "shell32.dll", 146)
	_GUIImageList_Add($hImage, _GUICtrlTreeView_CreateSolidBitMap($idTreeView, 0xFF0000, 16, 16))
	_GUIImageList_Add($hImage, _GUICtrlTreeView_CreateSolidBitMap($idTreeView, 0x00FF00, 16, 16))
	_GUIImageList_Add($hImage, _GUICtrlTreeView_CreateSolidBitMap($idTreeView, 0x0000FF, 16, 16))
	_GUICtrlTreeView_SetNormalImageList($idTreeView, $hImage)

	_GUICtrlTreeView_BeginUpdate($idTreeView)
	For $x = 1 To Random(2, 10, 1)
		$iImage = Random(0, 8, 1)
		$hItem = _GUICtrlTreeView_Add($idTreeView, 0, StringFormat("[%02d] New Item", $x), $iImage, $iImage)
		For $y = 1 To Random(2, 10, 1)
			$iImage = Random(0, 8, 1)
			_GUICtrlTreeView_AddChild($idTreeView, $hItem, StringFormat("[%02d] New Child", $y), $iImage, $iImage)
		Next
	Next
	_GUICtrlTreeView_EndUpdate($idTreeView)
	_GUICtrlTreeView_SelectItem($idTreeView, 0)

	; Loop until the user exits.
	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_MOUSEMOVE
				If $bDragging Then DrawDragImage($idTreeView, $aDrag)

			Case $GUI_EVENT_PRIMARYDOWN
				Local $hSelected = _GUICtrlTreeView_GetSelection($idTreeView)
				If $hSelected Then
					$bDragging = True
					; Create drag image
					$aDrag = _GUICtrlTreeView_CreateDragImage($idTreeView, $hSelected)
					DrawDragImage($idTreeView, $aDrag)
				EndIf

			Case $GUI_EVENT_PRIMARYUP
				If $bDragging Then
					$bDragging = False
					; delete image list
					_GUIImageList_Destroy($aDrag)
					_WinAPI_InvalidateRect($idTreeView)
					_WinAPI_InvalidateRect(HWnd($hGUI))
				EndIf
			Case $GUI_EVENT_CLOSE
				ExitLoop
		EndSwitch
	WEnd
	GUIDelete()
EndFunc   ;==>Example

; Draw drag image
Func DrawDragImage(ByRef $hControl, ByRef $aDrag)
	Local $tPoint, $hDC
	$hDC = _WinAPI_GetWindowDC($hControl)
	$tPoint = _WinAPI_GetMousePos(True, $hControl)
	_WinAPI_InvalidateRect($hControl)
	_GUIImageList_Draw($aDrag, 0, $hDC, DllStructGetData($tPoint, "X"), DllStructGetData($tPoint, "Y"))
	_WinAPI_ReleaseDC($hControl, $hDC)
EndFunc   ;==>DrawDragImage
