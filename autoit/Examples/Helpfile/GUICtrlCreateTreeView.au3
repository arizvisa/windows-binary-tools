#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>
#include <StaticConstants.au3>
#include <TreeViewConstants.au3>
#include <WindowsConstants.au3>

Example()

Func Example()
	GUICreate("My GUI with treeview", 350, 215)

	Local $idTreeview = GUICtrlCreateTreeView(6, 6, 100, 150, BitOR($TVS_HASBUTTONS, $TVS_HASLINES, $TVS_LINESATROOT, $TVS_DISABLEDRAGDROP, $TVS_SHOWSELALWAYS), $WS_EX_CLIENTEDGE)
	Local $idGeneralitem = GUICtrlCreateTreeViewItem("General", $idTreeview)
	GUICtrlSetColor(-1, 0x0000C0)
	Local $idDisplayitem = GUICtrlCreateTreeViewItem("Display", $idTreeview)
	GUICtrlSetColor(-1, 0x0000C0)
	Local $idAboutitem = GUICtrlCreateTreeViewItem("About", $idGeneralitem)
	Local $idCompitem = GUICtrlCreateTreeViewItem("Computer", $idGeneralitem)
	GUICtrlCreateTreeViewItem("User", $idGeneralitem)
	GUICtrlCreateTreeViewItem("Resolution", $idDisplayitem)
	GUICtrlCreateTreeViewItem("Other", $idDisplayitem)

	Local $idStartlabel = GUICtrlCreateLabel("TreeView Demo", 190, 90, 100, 20)
	Local $idAboutlabel = GUICtrlCreateLabel("This little scripts demonstates the using of a treeview-control.", 190, 70, 100, 60)
	GUICtrlSetState(-1, $GUI_HIDE) ; Hides the "aboutlabel"-text during initialization
	Local $idCompinfo = GUICtrlCreateLabel("Name:" & @TAB & @ComputerName & @CRLF & "OS:" & @TAB & @OSVersion & @CRLF & "SP:" & @TAB & @OSServicePack, 120, 30, 200, 80)
	GUICtrlSetState(-1, $GUI_HIDE) ; Hides the "compinfo"-text during initialization

	GUICtrlCreateLabel("", 0, 170, 350, 2, $SS_SUNKEN)
	Local $idTogglebutton = GUICtrlCreateButton("&Toggle", 35, 185, 70, 20)
	Local $idInfobutton = GUICtrlCreateButton("&Info", 105, 185, 70, 20)
	Local $idStatebutton = GUICtrlCreateButton("Col./Exp.", 175, 185, 70, 20)
	Local $idCancelbutton = GUICtrlCreateButton("&Cancel", 245, 185, 70, 20)

	GUICtrlSetState($idGeneralitem, BitOR($GUI_EXPAND, $GUI_DEFBUTTON)) ; Expand the "General"-item and paint in bold
	GUICtrlSetState($idDisplayitem, BitOR($GUI_EXPAND, $GUI_DEFBUTTON)) ; Expand the "Display"-item and paint in bold

	GUISetState(@SW_SHOW)

	Local $idMsg, $idItem, $hItem, $sText
	; Loop until the user exits.
	While 1
		$idMsg = GUIGetMsg()
		Select
			Case $idMsg = $idCancelbutton Or $idMsg = $GUI_EVENT_CLOSE
				ExitLoop

			Case $idMsg = $idTogglebutton ; Toggle the bold painting
				If BitAND(GUICtrlRead($idGeneralitem), $GUI_DEFBUTTON) Then
					GUICtrlSetState($idGeneralitem, 0)
					GUICtrlSetState($idDisplayitem, 0)
				Else
					GUICtrlSetState($idGeneralitem, $GUI_DEFBUTTON)
					GUICtrlSetState($idDisplayitem, $GUI_DEFBUTTON)
				EndIf

			Case $idMsg = $idInfobutton
				$idItem = GUICtrlRead($idTreeview) ; Get the controlID of the current selected treeview item
				If $idItem = 0 Then
					MsgBox($MB_SYSTEMMODAL, "TreeView Demo", "No item currently selected")
				Else
					$sText = GUICtrlRead($idItem, 1) ; Get the text of the treeview item
					If $sText == "" Then
						MsgBox($MB_SYSTEMMODAL, "Error", "Error while retrieving infos about item")
					Else
						MsgBox($MB_SYSTEMMODAL, "TreeView Demo", "Current item selected is: " & $sText)
					EndIf
				EndIf

			Case $idMsg = $idStatebutton
				$idItem = GUICtrlRead($idTreeview)
				If $idItem > 0 Then
					$hItem = GUICtrlGetHandle($idItem)
					GUICtrlSendMsg($idTreeview, $TVM_EXPAND, $TVE_TOGGLE, $hItem)
				EndIf

				; The following items will hide the other labels (1st and 2nd parameter) and then show the 'own' labels (3rd and 4th parameter)
			Case $idMsg = $idGeneralitem
				GUIChangeItems($idAboutlabel, $idCompinfo, $idStartlabel, $idStartlabel)

			Case $idMsg = $idAboutitem
				GUICtrlSetState($idCompinfo, $GUI_HIDE)
				GUIChangeItems($idStartlabel, $idStartlabel, $idAboutlabel, $idAboutlabel)

			Case $idMsg = $idCompitem
				GUIChangeItems($idStartlabel, $idAboutlabel, $idCompinfo, $idCompinfo)
		EndSelect
	WEnd

	GUIDelete()
EndFunc   ;==>Example

Func GUIChangeItems($idHidestart, $idHideend, $idShowstart, $idShowend)
	Local $idX

	For $idX = $idHidestart To $idHideend
		GUICtrlSetState($idX, $GUI_HIDE)
	Next
	For $idX = $idShowstart To $idShowend
		GUICtrlSetState($idX, $GUI_SHOW)
	Next
EndFunc   ;==>GUIChangeItems
