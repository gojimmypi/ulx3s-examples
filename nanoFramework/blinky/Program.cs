using System;
using System.Threading;
using nanoFramework.Hardware.Esp32;
using Windows.Devices.Gpio;

namespace blinky
{
    public class Program
    {
        public static void Main()
        {
            Console.WriteLine("Hello world!");
            int a = 1;
            Console.WriteLine("Hello world! " + a.ToString());




            GpioPin led = GpioController.GetDefault().OpenPin(5);
            led.SetDriveMode(GpioPinDriveMode.Output);
            led.Write(GpioPinValue.Low);

            while (true)
            {
                led.Toggle();
                Thread.Sleep(125);
                led.Toggle();
                Thread.Sleep(125);
                led.Toggle();
                Thread.Sleep(125);
                led.Toggle();
                Thread.Sleep(525);
            }





            // Thread.Sleep(Timeout.Infinite);

            // Browse our samples repository: https://github.com/nanoframework/samples
            // Check our documentation online: https://docs.nanoframework.net/
            // Join our lively Discord community: https://discord.gg/gCyBu8T
        }
    }
}
