using System;
using System.Threading;
using nanoFrameworkSSD1331;

namespace nanoFrameworkSSD1331_demo
{
    public class Program
    {
        public static void Main()
        {

            // ULX3S
            byte oled_csn = 17; // aka cs - chip select
            byte oled_dc = 16; // aka ds aka a0 -  SPI data or command selector pin
            byte oled_resn = 25; // aka rst - reset
            byte oled_mosi = 15; // aka mosi - data
            byte oled_clk = 14; // aka sclk - clock
            // byte oled_miso = -1; // 12 not used


            // HSPI see https://github.com/espressif/arduino-esp32/blob/7d7824701fe5e22f08555d3e1ce3180a922b2151/libraries/SPI/examples/SPI_Multiple_Buses/SPI_Multiple_Buses.ino#L37
            // initialise hspi with default pins SCLK = 14, MISO = 12, MOSI = 13, SS = 15
            // working WROOM-32 using HSPI (does not work on ULX3S)
            //byte oled_csn = 15; // white aka cs - chip select
            //byte oled_dc = 26; // orange aka ds aka a0 -  SPI data or command selector pin
            //byte oled_resn = 27; // gray aka rst - reset
            //byte oled_mosi = 13; // purple aka mosi - data
            //byte oled_clk = 14; // blue aka sclk - clock
            //byte oled_miso = -1; //  not used

            OLED_SSD1331 myDisplay = new OLED_SSD1331(oled_csn, oled_dc, oled_mosi, oled_clk, oled_resn);

            for (int i = 0; i < 64; i++)
            {
                myDisplay.drawPixel(x: (byte)(i + 0), y: (byte)i, (ushort)(36 + i));
                myDisplay.drawPixel(x: (byte)(i + 1), y: (byte)i, (ushort)(36 + i));
                myDisplay.drawPixel(x: (byte)(i + 2), y: (byte)i, (ushort)(36 + i));
                myDisplay.drawPixel(x: (byte)(i + 3), y: (byte)i, (ushort)(36 + i));
            }
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
