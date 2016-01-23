#include <FontConstants.au3>
#include <WinAPIGdi.au3>

Local Const $sFaceName = 'Arial'

ConsoleWrite($sFaceName & ' Regular => ' & _WinAPI_GetFontName($sFaceName, $FS_REGULAR) & @CRLF)
ConsoleWrite($sFaceName & ' Bold => ' & _WinAPI_GetFontName($sFaceName, $FS_BOLD) & @CRLF)
ConsoleWrite($sFaceName & ' Italic => ' & _WinAPI_GetFontName($sFaceName, $FS_ITALIC) & @CRLF)
ConsoleWrite($sFaceName & ' Bold Italic => ' & _WinAPI_GetFontName($sFaceName, BitOR($FS_BOLD, $FS_ITALIC)) & @CRLF)
