using System;
using nanoFramework.Hardware.Esp32;
using Windows.Devices.Spi;
using System.Threading;
using Windows.Devices.Gpio;

namespace nanoFrameworkArduinoHelper
{
    static public class PinsArduinoHelper
    {
        public enum PinDirection { INPUT, OUTPUT, INPUT_PULLUP };
        public enum PinLevel { LOW, HIGH }

        static PinDirection OUTPUT = PinDirection.OUTPUT;
        static PinDirection INPUT = PinDirection.INPUT;
        static PinDirection INPUT_PULLUP = PinDirection.INPUT_PULLUP;
        static PinLevel HIGH = PinLevel.HIGH;
        static PinLevel LOW = PinLevel.LOW;

        static GpioPin[] thisPin = new GpioPin[34];
        public static void pinMode(byte p, PinDirection d)
        {
            if (thisPin[p] == null)
            {
                thisPin[p] = GpioController.GetDefault().OpenPin(p);
            }
            if (d == OUTPUT)
            {
                thisPin[p].SetDriveMode(GpioPinDriveMode.Output);
            }
            else if (d == INPUT)
            {
                thisPin[p].SetDriveMode(GpioPinDriveMode.Input);
            }
            else if (d == INPUT_PULLUP)
            {
                thisPin[p].SetDriveMode(GpioPinDriveMode.InputPullUp);
            }
            //            led.Write(GpioPinValue.Low);
        }

        public static void digitalWrite(byte p, PinLevel s)
        {
            if (thisPin[p] == null)
            {
                thisPin[p] = GpioController.GetDefault().OpenPin(p);
            }
            if (s == PinLevel.HIGH)
            {
                thisPin[p].Write(Windows.Devices.Gpio.GpioPinValue.High);
            }
            else
            {
                thisPin[p].Write(Windows.Devices.Gpio.GpioPinValue.Low);
            }
        }
    }

}
