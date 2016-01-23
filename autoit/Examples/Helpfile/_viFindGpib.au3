; This example performs a search on the GPIB bus and shows the results in a MsgBox

#include <Visa.au3>

Local $a_Descriptor_list[1], $a_Idn_list[1]
_viFindGpib($a_Descriptor_list, $a_Idn_list, 1)
