; AutoIt GUI Example
; Created: 17/01/2005 - CyberSlug
; Modifed: 05/12/2011 - guinness
; Modifed: 09/06/2014 - mLipok

#Region INCLUDE
#include <AVIConstants.au3>
#include <GuiConstantsEx.au3>
#include <TreeViewConstants.au3>
#EndRegion INCLUDE

#Region GUI
GUICreate("Sample GUI", 400, 400)
GUISetIcon(@SystemDir & "\mspaint.exe", 0)
#EndRegion GUI

#Region MENU
Local $idMenu1 = GUICtrlCreateMenu("Menu &One")
Local $idMenu2 = GUICtrlCreateMenu("Menu &Two")
GUICtrlCreateMenu("Menu Th&ree")
GUICtrlCreateMenu("Menu &Four")
GUICtrlCreateMenuItem('SubMenu One &A', $idMenu1)
GUICtrlCreateMenuItem('SubMenu One &B', $idMenu1)
#EndRegion MENU

#Region CONTEXT MENU
Local $idContextMenu = GUICtrlCreateContextMenu()
GUICtrlCreateMenuItem("Context Menu", $idContextMenu)
GUICtrlCreateMenuItem("", $idContextMenu) ; Separator
GUICtrlCreateMenuItem("&Properties", $idContextMenu)
#EndRegion CONTEXT MENU

#Region PIC
GUICtrlCreatePic("logo4.gif", 0, 0, 169, 68)
GUICtrlSetTip(-1, '#Region PIC')
GUICtrlCreateLabel("Sample Pic", 75, 1, 53, 15)
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
GUICtrlSetColor(-1, 0xFFFFFF)
#EndRegion PIC

#Region AVI
GUICtrlCreateAvi("SampleAVI.avi", 0, 180, 10, 32, 32, $ACS_AUTOPLAY)
GUICtrlSetTip(-1, '#Region AVI') ; TODO
GUICtrlCreateLabel("Sample avi", 175, 50)
GUICtrlSetTip(-1, '#Region AVI - Label')
#EndRegion AVI

#Region TAB
GUICtrlCreateTab(240, 0, 150, 70)
GUICtrlCreateTabItem("One")
GUICtrlSetTip(-1, '#Region TAB1')
GUICtrlCreateLabel("Sample Tab with TabItems", 250, 40)
GUICtrlCreateTabItem("Two")
GUICtrlSetTip(-1, '#Region TAB2')
GUICtrlCreateTabItem("Three")
GUICtrlSetTip(-1, '#Region TAB3')
GUICtrlCreateTabItem("")
#EndRegion TAB

#Region COMBO
GUICtrlCreateCombo("Sample Combo", 250, 80, 120, 100)
GUICtrlSetTip(-1, '#Region COMBO')
#EndRegion COMBO

#Region PROGRESS
GUICtrlCreateProgress(60, 80, 150, 20)
GUICtrlSetTip(-1, '#Region PROGRES')
GUICtrlSetData(-1, 60)
GUICtrlCreateLabel("Progress:", 5, 82)
GUICtrlSetTip(-1, '#Region PROGRES - Label')
#EndRegion PROGRESS

#Region EDIT
GUICtrlCreateEdit(@CRLF & "  Sample Edit Control", 10, 110, 150, 70)
GUICtrlSetTip(-1, '#Region EDIT')
#EndRegion EDIT

#Region LIST
GUICtrlCreateList("", 5, 190, 100, 90)
GUICtrlSetTip(-1, '#Region LIST')
GUICtrlSetData(-1, "A.Sample|B.List|C.Control|D.Here", "B.List")
#EndRegion LIST

#Region ICON
GUICtrlCreateIcon("explorer.exe", 0, 175, 120)
GUICtrlSetTip(-1, '#Region ICON')
GUICtrlCreateLabel("Icon", 180, 160, 50, 20)
GUICtrlSetTip(-1, '#Region ICON - Label')
#EndRegion ICON

#Region LIST VIEW
Local $idListView = GUICtrlCreateListView("Sample|ListView|", 110, 190, 110, 80)
GUICtrlSetTip(-1, '#Region LIST VIEW')
GUICtrlCreateListViewItem("A|One", $idListView)
GUICtrlCreateListViewItem("B|Two", $idListView)
GUICtrlCreateListViewItem("C|Three", $idListView)
#EndRegion LIST VIEW

#Region GROUP WITH RADIO BUTTONS
GUICtrlCreateGroup("Sample Group", 230, 120)
GUICtrlCreateRadio("Radio One", 250, 140, 80)
GUICtrlSetTip(-1, '#Region GROUP WITH RADIO BUTTONS- RADIO1')
GUICtrlSetState(-1, $GUI_CHECKED)
GUICtrlCreateRadio("Radio Two", 250, 165, 80)
GUICtrlSetTip(-1, '#Region GROUP WITH RADIO BUTTONS- RADIO2')
GUICtrlCreateGroup("", -99, -99, 1, 1) ;close group
#EndRegion GROUP WITH RADIO BUTTONS

#Region UPDOWN
GUICtrlCreateLabel("UpDown", 350, 115)
GUICtrlSetTip(-1, '#Region UPDOWN - Label')
GUICtrlCreateInput("42", 350, 130, 40, 20)
GUICtrlSetTip(-1, '#Region UPDOWN - Input')
GUICtrlCreateUpdown(-1)
GUICtrlSetTip(-1, '#Region UPDOWN - Updown')
#EndRegion UPDOWN

#Region LABEL
GUICtrlCreateLabel("Green" & @CRLF & "Label", 350, 165, 40, 40)
GUICtrlSetTip(-1, '#Region LABEL')
GUICtrlSetBkColor(-1, 0x00FF00)
#EndRegion LABEL

#Region SLIDER
GUICtrlCreateLabel("Slider:", 235, 215)
GUICtrlSetTip(-1, '#Region SLIDER - Label')
GUICtrlCreateSlider(270, 210, 120, 30)
GUICtrlSetTip(-1, '#Region SLIDER')
GUICtrlSetData(-1, 30)
#EndRegion SLIDER

#Region INPUT
GUICtrlCreateInput("Sample Input Box", 235, 255, 130, 20)
GUICtrlSetTip(-1, '#Region INPUT')
#EndRegion INPUT

#Region DATE
GUICtrlCreateDate("", 5, 280, 200, 20)
GUICtrlSetTip(-1, '#Region DATE')
GUICtrlCreateLabel("(Date control expands into a calendar)", 10, 305, 200, 20)
GUICtrlSetTip(-1, '#Region DATE - Label')
#EndRegion DATE

#Region BUTTON
GUICtrlCreateButton("Sample Button", 10, 330, 100, 30)
GUICtrlSetTip(-1, '#Region BUTTON')
#EndRegion BUTTON

#Region CHECKBOX
GUICtrlCreateCheckbox("Checkbox", 130, 335, 80, 20)
GUICtrlSetTip(-1, '#Region CHECKBOX')
GUICtrlSetState(-1, $GUI_CHECKED)
#EndRegion CHECKBOX

#Region TREEVIEW ONE
Local $idTreeView_1 = GUICtrlCreateTreeView(210, 290, 80, 80)
GUICtrlSetTip(-1, '#Region TREEVIEW ONE')
Local $idTreeItem = GUICtrlCreateTreeViewItem("TreeView", $idTreeView_1)
GUICtrlCreateTreeViewItem("Item1", $idTreeItem)
GUICtrlCreateTreeViewItem("Item2", $idTreeItem)
GUICtrlCreateTreeViewItem("Foo", -1)
GUICtrlSetState($idTreeItem, $GUI_EXPAND)
#EndRegion TREEVIEW ONE

#Region TREEVIEW TWO
Local $idTreeView_2 = GUICtrlCreateTreeView(295, 290, 103, 80, $TVS_CHECKBOXES)
GUICtrlSetTip(-1, '#Region TREEVIEW TWO')
GUICtrlCreateTreeViewItem("TreeView", $idTreeView_2)
GUICtrlCreateTreeViewItem("With", $idTreeView_2)
GUICtrlCreateTreeViewItem("$TVS_CHECKBOXES", $idTreeView_2)
GUICtrlSetState(-1, $GUI_CHECKED)
GUICtrlCreateTreeViewItem("Style", $idTreeView_2)
#EndRegion TREEVIEW TWO

#Region GUI MESSAGE LOOP
GUISetState(@SW_SHOW)
While 1
	Switch GUIGetMsg()
		Case $GUI_EVENT_CLOSE
			ExitLoop

	EndSwitch
WEnd

GUIDelete()
#EndRegion GUI MESSAGE LOOP
