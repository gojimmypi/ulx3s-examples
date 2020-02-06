//-----------------------------------------------------------------------------
//
//                   ** WARNING! ** 
//    This file was generated automatically by a tool.
//    Re-running the tool will overwrite this file.
//    You should copy this file to a custom location
//    before adding any customization in the copy to
//    prevent loss of your changes when the tool is
//    re-run.
//
//-----------------------------------------------------------------------------
#include "nanoFrameworkSSD1331_extern.h"
#include "nanoFrameworkSSD1331_extern_nanoFrameworkSSD1331_extern_Utilities.h"

using namespace nanoFrameworkSSD1331_extern;

void Utilities::NativeGetHardwareSerial( CLR_RT_TypedArray_UINT8 param0, HRESULT &hr )
{
    if (param0.GetSize() < 12)
    {
        hr = CLR_E_BUFFER_TOO_SMALL;
        return;
    }

    memcpy((void*)param0.GetBuffer(), (const void*)0x1FFF7A10, 12);
}

