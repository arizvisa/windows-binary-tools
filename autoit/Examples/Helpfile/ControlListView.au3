#include <MsgBoxConstants.au3>

ControlListView(@ProgramFilesDir & "\AutoIt3", "", "SysListView321", "SelectAll")
ControlListView(@ProgramFilesDir & "\AutoIt3", "", "SysListView321", "Deselect", 2, 5)
MsgBox($MB_SYSTEMMODAL, "", ControlListView(@ProgramFilesDir & "\AutoIt3", "", "SysListView321", "GetText", 9, 0))
MsgBox($MB_SYSTEMMODAL, "", ControlListView(@ProgramFilesDir & "\AutoIt3", "", "SysListView321", "FindItem", "14 KB", 1))
MsgBox($MB_SYSTEMMODAL, "", ControlListView(@ProgramFilesDir & "\AutoIt3", "", "SysListView321", "GetSelected", 1))
