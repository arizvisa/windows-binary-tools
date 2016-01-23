; Open browser with basic example, click on the link with text "user forum"

#include <IE.au3>

Local $oIE = _IE_Example("basic")
_IELinkClickByText($oIE, "user forum")
