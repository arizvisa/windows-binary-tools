#include <MsgBoxConstants.au3>

#RequireAdmin

If IsAdmin() Then MsgBox($MB_SYSTEMMODAL, "", "The script is running with admin rights.")
