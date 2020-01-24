using System;
using System.Threading;
 

namespace blinky
{
    public class Program
    {
        public static void Main()
        {
            Console.WriteLine("Hello world!");
            int a = 1;
            Console.WriteLine("Hello world! " + a.ToString());

            Thread.Sleep(Timeout.Infinite);

            // Browse our samples repository: https://github.com/nanoframework/samples
            // Check our documentation online: https://docs.nanoframework.net/
            // Join our lively Discord community: https://discord.gg/gCyBu8T
        }
    }
}
