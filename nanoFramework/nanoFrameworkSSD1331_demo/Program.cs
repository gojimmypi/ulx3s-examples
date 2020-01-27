using System;
using System.Threading;
using nanoFrameworkSSD1331;

namespace nanoFrameworkSSD1331_demo
{
    public class Program
    {
        public static void Main()
        {
            byte oled_csn = 17; // aka cs - chip select
            byte oled_dc = 16; // aka ds aka a0 -  SPI data or command selector pin
            byte oled_resn = 25; // aka rst - reset
            byte oled_mosi = 15; // aka mosi - data
            byte oled_clk = 14; // aka sclk - clock
                                // byte oled_miso = -1; // 12 not used

            OLED_SSD1331 a = new OLED_SSD1331(oled_csn, oled_dc, oled_mosi, oled_clk, oled_resn);

            Console.WriteLine("Hello world!");
 
            //OLED_SSD1331.ToggleClock();
            //OLED_SSD1331.ToggleClock();
            //OLED_SSD1331.TogglePin(oled_csn);
            //OLED_SSD1331.TogglePin(oled_csn);
            //OLED_SSD1331.TogglePin(oled_dc);
            //OLED_SSD1331.TogglePin(oled_dc);
            //OLED_SSD1331.TogglePin(oled_resn);
            //OLED_SSD1331.TogglePin(oled_resn);
            //OLED_SSD1331.TogglePin(oled_mosi);
            //OLED_SSD1331.TogglePin(oled_mosi);
            //OLED_SSD1331.TogglePin(oled_clk);
            //OLED_SSD1331.TogglePin(oled_clk);

            Thread.Sleep(Timeout.Infinite);

            // Browse our samples repository: https://github.com/nanoframework/samples
            // Check our documentation online: https://docs.nanoframework.net/
            // Join our lively Discord community: https://discord.gg/gCyBu8T
        }
    }
}
