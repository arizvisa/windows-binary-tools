; Wait until no instance of Notepad exists.
ProcessWaitClose("notepad.exe")

; Wait until this particular instance of Notepad is closed by the user.
Local $iPID = Run("notepad.exe")
ProcessWaitClose($iPID)
