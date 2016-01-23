Local $bFileInstall = False ; Change to True and ammend the file paths accordingly.

; This will install the file C:\Test.bmp to the script location.
If $bFileInstall Then FileInstall("C:\Test.bmp", @ScriptDir & "\Test.bmp")
