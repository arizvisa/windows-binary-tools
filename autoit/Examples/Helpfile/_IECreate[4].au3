; Create an empty browser window and populate it with custom HTML

#include <IE.au3>

Local $oIE = _IECreate()
Local $sHTML = "<h1>Hello World!</h1>"
_IEBodyWriteHTML($oIE, $sHTML)
