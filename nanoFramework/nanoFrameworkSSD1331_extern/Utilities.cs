using System;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;

namespace nanoFrameworkSSD1331_extern
{
    // see https://jsimoesblog.wordpress.com/2018/06/19/interop-in-net-nanoframework/
    //
    // first "here" is 404: "suggest that you take a look the documentation about it [here](https://github.com/nanoframework/Home/tree/master/docs/building)"
    //
    // Version 1.2.4.2 is the known-to-work version of the nanoFramework extension that will actually create stub files at build time!
    // 
    // Versions greater may not build stub files!
    //
    // Note https://www.nuget.org/packages/SimpleStubs/2.4.8 can build stubs, but this package does not know what to do with nanoFramework
    //


    // Browse our samples repository: https://github.com/nanoframework/samples
    // Check our documentation online: https://docs.nanoframework.net/
    // Join our lively Discord community: https://discord.gg/gCyBu8T
    public class Utilities
    {
        private static byte[] _hardwareSerial;
        ///

        /// Gets the hardware unique serial ID (12 bytes)
        ///

        public static byte[] HardwareSerial
        {
            get
            {
                if (_hardwareSerial == null)
                {
                    _hardwareSerial = new byte[12];
                    NativeGetHardwareSerial(_hardwareSerial);
                }
                return _hardwareSerial;
            }
        }

        #region Stubs

        [MethodImpl(MethodImplOptions.InternalCall)]
        private static extern void NativeGetHardwareSerial(byte[] data);

        #endregion stubs
    }


}