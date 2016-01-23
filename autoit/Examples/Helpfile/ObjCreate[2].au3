#include <MsgBoxConstants.au3>

; Open the MediaPlayer on a REMOTE computer

Local $oRemoteMedia = ObjCreate("MediaPlayer.MediaPlayer.1", "name-of-remote-computer")

If Not @error Then
	MsgBox($MB_SYSTEMMODAL, "Remote ObjCreate Test", "ObjCreate() of a remote Mediaplayer Object successful !")
	$oRemoteMedia.Open(@WindowsDir & "\media\tada.wav") ; Play sound if file is present
Else
	MsgBox($MB_SYSTEMMODAL, "Remote ObjCreate Test", "Failed to open remote Object. Error code: " & Hex(@error, 8))
EndIf
