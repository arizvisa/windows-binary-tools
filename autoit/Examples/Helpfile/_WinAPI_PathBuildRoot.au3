#include <WinAPIShPath.au3>

For $i = 0 To 2
	ConsoleWrite(_WinAPI_PathBuildRoot($i) & @CRLF)
Next
