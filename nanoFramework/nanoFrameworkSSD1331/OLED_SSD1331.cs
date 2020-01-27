// OLED_SSD1331 in C# for the nanoFramework is based upon Adafruit_SSD1331
//
//  by gojimmypi
//
// the original Ardunio C++ source is here: 
//   https://github.com/adafruit/Adafruit-SSD1331-OLED-Driver-Library-for-Arduino/blob/master/Adafruit_SSD1331.cpp
// with this license:
/***************************************************
  This is a library for the 0.96" 16-bit Color OLED with SSD1331 driver chip
  Pick one up today in the adafruit shop!
  ------> http://www.adafruit.com/products/684
  These displays use SPI to communicate, 4 or 5 pins are required to
  interface
  Adafruit invests time and resources providing this open source code,
  please support Adafruit and open-source hardware by purchasing
  products from Adafruit!
  Written by Limor Fried/Ladyada for Adafruit Industries.
  BSD license, all text above must be included in any redistribution
 ****************************************************/

using System;
using nanoFramework.Hardware.Esp32;
using Windows.Devices.Spi;
using System.Threading;
using Windows.Devices.Gpio;
using static nanoFrameworkArduinoHelper.PinsArduinoHelper;
using static nanoFrameworkArduinoHelper.PinsArduinoHelper.PinDirection;
using static nanoFrameworkArduinoHelper.PinsArduinoHelper.PinLevel;

// API docs: https://docs.nanoframework.net/api/nanoFramework.Hardware.Esp32.html
// API docs: https://docs.nanoframework.net/api/Windows.Devices.Spi.html
// API docs: https://docs.nanoframework.net/api/Windows.Devices.Gpio.html
//
// Browse nanoframework samples repository: https://github.com/nanoframework/samples

// Check nanoframework documentation online: https://docs.nanoframework.net/

// Join nanoframework lively Discord community: https://discord.gg/gCyBu8T

// Report nanoframework issues: https://github.com/nanoframework/Home/issues

// Follow nanoframework on Twitter: https://twitter.com/nanoframework

// Follow our YouTube channel: https://www.youtube.com/c/nanoFramework


namespace nanoFrameworkSSD1331
{
    public class OLED_SSD1331
    {
        private byte _width = 96;
        private byte _height = 64;
        private byte _rst;            ///< Reset pin # (or -1)
        private byte _cs;             ///< Chip select pin # (or -1)
        private byte _dc;             ///< Data/command pin #
        private byte _mosi;           ///< MOSI pin #
        private byte _miso;           ///< MISO pin #
        private byte _sck;            ///< SCK pin #

        // OLED SSD1331 Commands
        enum Cmds
        {
            // Timing Delays
            SSD1331_DELAYS_HWFILL = 3,
            SSD1331_DELAYS_HWLINE = 1,

            // SSD1331 Commands
            SSD1331_CMD_DRAWLINE = 0x21,
            SSD1331_CMD_DRAWRECT = 0x22,
            SSD1331_CMD_FILL = 0x26,
            SSD1331_CMD_SETCOLUMN = 0x15,
            SSD1331_CMD_SETROW = 0x75,
            SSD1331_CMD_CONTRASTA = 0x81,
            SSD1331_CMD_CONTRASTB = 0x82,
            SSD1331_CMD_CONTRASTC = 0x83,
            SSD1331_CMD_MASTERCURRENT = 0x87,
            SSD1331_CMD_SETREMAP = 0xA0,
            SSD1331_CMD_STARTLINE = 0xA1,
            SSD1331_CMD_DISPLAYOFFSET = 0xA2,
            SSD1331_CMD_NORMALDISPLAY = 0xA4,
            SSD1331_CMD_DISPLAYALLON = 0xA5,
            SSD1331_CMD_DISPLAYALLOFF = 0xA6,
            SSD1331_CMD_INVERTDISPLAY = 0xA7,
            SSD1331_CMD_SETMULTIPLEX = 0xA8,
            SSD1331_CMD_SETMASTER = 0xAD,
            SSD1331_CMD_DISPLAYOFF = 0xAE,
            SSD1331_CMD_DISPLAYON = 0xAF,
            SSD1331_CMD_POWERMODE = 0xB0,
            SSD1331_CMD_PRECHARGE = 0xB1,
            SSD1331_CMD_CLOCKDIV = 0xB3,
            SSD1331_CMD_PRECHARGEA = 0x8A,
            SSD1331_CMD_PRECHARGEB = 0x8B,
            SSD1331_CMD_PRECHARGEC = 0x8C,
            SSD1331_CMD_PRECHARGELEVEL = 0xBB,
            SSD1331_CMD_VCOMH = 0xBE
        }

        #region Driver Read/Write        

        private void sendCommand(Cmds i)
        {
            sendCommand((byte)i, null);
        }


        private void sendData(byte[] b)
        {

        }

        private void spiWrite(byte b)
        {
            for (byte bit = 0; bit < 8; bit++)
            {
                if ((b & 0x80) > 0)
                {
                    SPI_MOSI_HIGH();
                }
                else
                {
                    SPI_MOSI_LOW();
                }
                SPI_SCK_HIGH();
                b <<= 1;
                SPI_SCK_LOW();
            }
        }

        private void SPI_WRITE16(UInt16 b)
        {
            for (byte bit = 0; bit < 16; bit++)
            {
                if ((b & 0x8000) > 0)
                {
                    SPI_MOSI_HIGH();
                }
                else
                {
                    SPI_MOSI_LOW();
                }
                SPI_SCK_HIGH();
                b <<= 1;
                SPI_SCK_LOW();
            }
            TFT_WR_STROBE();
        }

        private void TFT_WR_STROBE()
        {
            // we don't have a write strobe pin!
            //digitalWrite(_wr, LOW);
            //digitalWrite(_wr, HIGH);
        }
        /// <summary>
        /// Send a command to the controller
        /// </summary>
        /// <param name="cmd">The command to send</param>
        protected void sendCommand(byte commandByte, byte[] dataBytes = null)
        {
            // byte[] cmdBuf = { cmd };
            if (_cs >= 0) SPI_CS_LOW();

            SPI_DC_LOW(); // Command mode
            spiWrite(commandByte); // Send the command byte

            SPI_DC_HIGH();

            SendData(dataBytes);

            if (_cs >= 0) SPI_CS_HIGH();

            //if (_cs >= 0) SPI_CS_LOW();

            //digitalWrite(_dc, LOW);
            //digitalWrite(_cs, LOW);
            //SPI_DC_LOW(); // Command mode

            //digitalWrite(_dc, HIGH);
            //digitalWrite(_cs, HIGH);
        }

        private void SPI_CS_LOW()
        {
            digitalWrite(_cs, LOW);
        }
        private void SPI_CS_HIGH()
        {
            digitalWrite(_cs, HIGH);
        }
        private void SPI_DC_LOW()
        {
            digitalWrite(_dc, LOW);
        }
        private void SPI_DC_HIGH()
        {
            digitalWrite(_dc, HIGH);
        }
        private void SPI_SCK_LOW()
        {
            digitalWrite(_sck, LOW);
        }
        private void SPI_SCK_HIGH()
        {
            digitalWrite(_sck, HIGH);
        }
        private void SPI_MOSI_HIGH()
        {
            digitalWrite(_mosi, HIGH);
        }
        private void SPI_MOSI_LOW()
        {
            digitalWrite(_mosi, LOW);
        }
        /// <summary>
        /// Send the data as byte array 
        /// </summary>
        /// <param name="data">Byte array</param>
        protected void SendData(byte[] dataBytes)
        {
            digitalWrite(_dc, HIGH);
            if (_cs >= 0) SPI_CS_LOW();

             if (dataBytes != null)
            {
                for (int i = 0; i < dataBytes.Length; i++)
                {
                    spiWrite(dataBytes[i]); // Send the data bytes
                }
            }



            digitalWrite(_cs, HIGH);

        }
        /// <summary>
        /// Send the data as byte array 
        /// </summary>
        /// <param name="data">Byte array</param>
        /// <param name="len">Number of items to send from the buffer</param>
        protected void SendData(byte[] data, int len)
        {
            byte[] dataToSend = new byte[len];
            Array.Copy(data, 0, dataToSend, 0, len);
            SendData(dataToSend);
            dataToSend = null;
        }
        /// <summary>
        /// Send data, single-byte
        /// </summary>
        /// <param name="data">Single byte data</param>
        protected void SendData(byte data)
        {
            byte[] dataBuf = { data };
            SendData(dataBuf);
            dataBuf = null;
        }

        #endregion


        private void initSPI(long f)
        {
            // Init basic control pins common to all connection types
            if (_cs >= 0)
            {
                pinMode(_cs, OUTPUT);
                digitalWrite(_cs, HIGH); // Deselect
            }
            pinMode(_dc, OUTPUT);
            digitalWrite(_dc, HIGH); // Data mode

            // soft SPI
            pinMode(_mosi, OUTPUT);
            digitalWrite(_mosi, LOW);
            pinMode(_sck, OUTPUT);
            digitalWrite(_sck, LOW);
            if (_miso >= 0)
            {
                pinMode(_miso, INPUT);
            }

            //pinMode(_wr, OUTPUT);
            //digitalWrite(_wr, HIGH);
            //if (_rd >= 0)
            //{
            //    pinMode(_rd, OUTPUT);
            //    digitalWrite(_rd, HIGH);
            //}

            if (_rst >= 0)
            {
                // Toggle _rst low to reset
                pinMode(_rst, OUTPUT);
                digitalWrite(_rst, HIGH);
                Thread.Sleep(100);
                digitalWrite(_rst, LOW);
                Thread.Sleep(100);
                digitalWrite(_rst, HIGH);
                Thread.Sleep(200);
            }
        }
        public void Initialize()
        {
            initSPI(16000000L);

            // Initialization Sequence
            sendCommand(Cmds.SSD1331_CMD_DISPLAYOFF);    // 0xAE
            sendCommand(Cmds.SSD1331_CMD_SETREMAP);  // 0xA0

            sendCommand(0x72);				// RGB Color
            //sendCommand(0x76);              // BGR Color
            sendCommand(Cmds.SSD1331_CMD_STARTLINE);     // 0xA1
            sendCommand((byte)0x00);
            sendCommand(Cmds.SSD1331_CMD_DISPLAYOFFSET);     // 0xA2
            sendCommand((byte)0x00);
            sendCommand(Cmds.SSD1331_CMD_NORMALDISPLAY);     // 0xA4
            sendCommand(Cmds.SSD1331_CMD_SETMULTIPLEX);  // 0xA8
            sendCommand(0x3F);              // 0x3F 1/64 duty
            sendCommand(Cmds.SSD1331_CMD_SETMASTER);     // 0xAD
            sendCommand(0x8E);
            sendCommand(Cmds.SSD1331_CMD_POWERMODE);     // 0xB0
            sendCommand(0x0B);
            sendCommand(Cmds.SSD1331_CMD_PRECHARGE);     // 0xB1
            sendCommand(0x31);
            sendCommand(Cmds.SSD1331_CMD_CLOCKDIV);      // 0xB3
            sendCommand(0xF0);  // 7:4 = Oscillator Frequency, 3:0 = CLK Div Ratio (A[3:0]+1 = 1..16)
            sendCommand(Cmds.SSD1331_CMD_PRECHARGEA);    // 0x8A
            sendCommand(0x64);
            sendCommand(Cmds.SSD1331_CMD_PRECHARGEB);    // 0x8B
            sendCommand(0x78);
            sendCommand(Cmds.SSD1331_CMD_PRECHARGEC);    // 0x8C
            sendCommand(0x64);
            sendCommand(Cmds.SSD1331_CMD_PRECHARGELEVEL);    // 0xBB
            sendCommand(0x3A);
            sendCommand(Cmds.SSD1331_CMD_VCOMH);         // 0xBE
            sendCommand(0x3E);
            sendCommand(Cmds.SSD1331_CMD_MASTERCURRENT);     // 0x87
            sendCommand(0x06);
            sendCommand(Cmds.SSD1331_CMD_CONTRASTA);     // 0x81
            sendCommand(0x91);
            sendCommand(Cmds.SSD1331_CMD_CONTRASTB);     // 0x82
            sendCommand(0x50);
            sendCommand(Cmds.SSD1331_CMD_CONTRASTC);     // 0x83
            sendCommand(0x7D);
            sendCommand(Cmds.SSD1331_CMD_DISPLAYON); //--turn on oled panel
                                                     //_width = TFTWIDTH; // 96
                                                     //_height = TFTHEIGHT; //65

            digitalWrite(_dc, HIGH);

            digitalWrite(_cs, LOW);
            // SendData(myWrite);
            digitalWrite(_cs, HIGH); // do we really want to taggle here?

            Thread.Sleep(125); // this is just for a visual indicator in logic analyzer
        }


        public OLED_SSD1331(byte cs, byte dc, byte mosi, byte sclk, byte rst)
        {
            _cs = cs;
            _dc = dc;
            _mosi = mosi;
            _sck = sclk;
            _rst = rst;
            Initialize();

        }

        static public void ToggleClock()
        {

            pinMode(14, PinDirection.OUTPUT);
            digitalWrite(14, PinLevel.LOW);
            Thread.Sleep(125);
            digitalWrite(14, PinLevel.HIGH);
            Thread.Sleep(125);
        }

        static public void TogglePin(byte p)
        {
            pinMode(p, PinDirection.OUTPUT);
            digitalWrite(p, PinLevel.LOW);
            Thread.Sleep(125);
            digitalWrite(p, PinLevel.HIGH);
            Thread.Sleep(125);
        }


        static public void SPI_BEGIN_TRANSACTION()
        {

        }
        static public void SPI_END_TRANSACTION()
        {

        }

        void startWrite()
        {
            SPI_BEGIN_TRANSACTION();
            if (_cs >= 0) SPI_CS_LOW();
        }

        void endWrite()
        {
            if (_cs >= 0) SPI_CS_HIGH();
            SPI_END_TRANSACTION();
        }

        public void drawPixel(byte x, byte y, ushort color)
        {
            // Clip first...
            if ((x >= 0) && (x < _width) && (y >= 0) && (y < _height))
            {
                // THEN set up transaction (if needed) and draw...
                startWrite();
                setAddrWindow(x, y, 1, 1);
                SPI_WRITE16(color);
                endWrite();
            }
        }

        public void setAddrWindow(byte x, byte y, byte w, byte h)
        {

            byte x1 = x;
            byte y1 = y;
            if (x1 > 95) x1 = 95;
            if (y1 > 63) y1 = 63;

            byte x2 = (byte)(x + w - 1);
            byte y2 = (byte)(y + h - 1);
            if (x2 > 95) x2 = 95;
            if (y2 > 63) y2 = 63;

            if (x1 > x2)
            {
                byte t = x2;
                x2 = x1;
                x1 = t;
            }
            if (y1 > y2)
            {
                byte t = y2;
                y2 = y1;
                y1 = t;
            }

            sendCommand(0x15); // Column addr set
            sendCommand(x1);
            sendCommand(x2);

            sendCommand(0x75); // Column addr set
            sendCommand(y1);
            sendCommand(y2);

            startWrite();

        }
    }
}
