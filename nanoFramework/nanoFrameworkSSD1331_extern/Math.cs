using System;
using System.Text;
using System.Runtime.CompilerServices;

namespace nanoFrameworkSSD1331_extern
{
    public class Math
    {
        ///

        /// Crunches value through a super complicated and secret calculation algorithm .
        ///

        /// Value to crunch.
        ///
        public double SuperComplicatedCalculation(double value)
        {
            return NativeSuperComplicatedCalculation(value);
        }

        #region Stubs

        [MethodImplAttribute(MethodImplOptions.InternalCall)]
        private static extern double NativeSuperComplicatedCalculation(double value);

        #endregion stubs
    }

}
