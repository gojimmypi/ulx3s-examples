# Requirements

- Visual Studio 2017 or 2019 with nanoFramework extension
- Python
- ULX3S (or any ESP32 WROOM device)

# Programming the ULX3S ESP32 using C# in Visual Studio

In order to program the ESP32 on the ULX3S, the [PassThru FPGA](../passthru/README.md) code needs to first be loaded.

Programming in C# will require the [nanoFramework Extension for Visual Studio 2019](https://marketplace.visualstudio.com/items?itemName=nanoframework.nanoFramework-VS2019-Extension)
or the [nanoFramework Extension for Visual Studio 2017](https://marketplace.visualstudio.com/items?itemName=vs-publisher-1470366.nanoFrameworkVS2017Extension); yes, they are different!

Next, if you want to compile the [nanoFramework](https://nanoframework.net/) itself, the Arduino IDE ensure that the Espressif SDK 1.0.1 or later is installed. For more details, see the [ESP32 Blinky for ULX3S](../../blinky/ESP32/README.md)

# Quickstart C# on the ULX3S ESP32

In order to program C# on the ESP32, a special bootloader is needed.

See the [upload_firmware.bat](./upload_firmware.bat); this uploads the binaries in [./bin/](./bin/) to the ESP32.

You'll need to know the USB port of your ESP32:

![device_manager_com_port.png](./images/device_manager_com_port.png)

Example:

```
c:
if not exist c:\workspace mkdir c:\workspace
cd\workspace
git clone https://github.com/gojimmypi/ulx3s-examples.git
cd ulx3s-examples\nanoFramework

upload_firmware.bat COM5
```

If these binaries do not work, check the versions. The latest binaries can be downloaded from [here](https://github.com/nanoframework/nf-interpreter#firmware-for-reference-boards).
Note the files are not hosted on GitHub. Don't despair if there are no downloads available, click on the "Files" for a download. Might be nice to have the GitHub links go directly there.

![precompiled_binaries_on_files_tab](./images/precompiled_binaries_on_files_tab.png)


# Installing the nanoFramework.

The first thing to consider is if the nanoFramwork supports the ESP32 on the ULX3S. 
The documentation explicitly calls out the ESP32 DevKit-C. 
The ULX3S uses the ESP WROOM-32. 
The [Espressif docs indicates the DevKitC also uses the WROOM-32](https://www.espressif.com/en/products/hardware/esp32-devkitc/overview):

![SP32-DevKitC docs](./images/ESP32-DevKitC.png )

The easiest way to install the nanoFramework extension is from the Visual Studio `Extensions - Manage Extensions`:

![VisualStudio_nanoFramework_Marketplace](./images/VisualStudio_nanoFramework_Marketplace.png)

# Find ULX3S in Device Explorer

Key to uploading C#-compiled code, is ensuring Visual Studio can "see" the devices. Ensure the ULX3S is plugged into a USB port.
Click on `View - Other Windows - Device Explorer`. If the device is not listed, you may need to exist Visual Studio and try again.
There does not appear to be a "device refresh / rescan" feature. When found, it should look something like this:
 
![device explorer](./images/device_explorer.png)

# Create a Project

There does not seem to be an easy way to browse to the project type:

![visual_studio_no_project](./images/visual_studio_no_project.png)

So you may need to search for it:

![visual_studio_search_project](./images/visual_studio_search_project.png)

# Troubleshooting

If you see an error like this when attempting to flash the nanoFramework firmware:

```
Traceback (most recent call last):
  File "..\bin\ESP32\esptool.py", line 25, in <module>
    import serial
ImportError: No module named serial
```
See [Issue 350](https://github.com/espressif/esptool/issues/350) and try: 

```
pip install pyserial
```

This error typically means the wrong COM port was specified:
```
Traceback (most recent call last):
  File "..\bin\ESP32\esptool.py", line 2524, in <module>
    _main()
  File "..\bin\ESP32\esptool.py", line 2517, in _main
    main()
  File "..\bin\ESP32\esptool.py", line 2246, in main
    esp = chip_class(args.port, initial_baud)
  File "..\bin\ESP32\esptool.py", line 177, in __init__
    self._port = serial.serial_for_url(port)
  File "C:\Python27\lib\site-packages\serial\__init__.py", line 88, in serial_for_url
    instance.open()
  File "C:\Python27\lib\site-packages\serial\serialwin32.py", line 62, in open
    raise SerialException("could not open port {!r}: {!r}".format(self.portstr, ctypes.WinError()))
serial.serialutil.SerialException: could not open port 'COM5': WindowsError(2, 'The system cannot find the file specified.')
```

if you see an error like "Couldn't find a valid native assembly required by mscorlib v1.3.0.3":

![failure_mscorlib_missing](./images/failure_mscorlib_missing.png)

Ensure the Core Library checkbox is checked in `Tools - NuGet Package Manager - Manage NuGet Packages for Solution`

![nuget_checkbox.png](./images/nuget_checkbox.png)

# Building the nanoFramework bootloader.

See the [source code](https://github.com/nanoframework/nf-interpreter/tree/develop/targets/FreeRTOS_ESP32/ESP32_WROOM_32).


# Links:

https://nanoframework.net/

https://www.espressif.com/en/products/hardware/esp32-devkitc/overview

https://en.wikipedia.org/wiki/ESP32#Programming

https://github.com/nanoframework/nf-Visual-Studio-extension

https://marketplace.visualstudio.com/items?itemName=nanoframework.nanoFramework-VS2019-Extension

https://nanoframework.net/home/getting-started-guides/

http://docs.nanoframework.net/content/getting-started-guides/getting-started-managed.html

https://nanoframework.net/2018/05/16/setup-visual-studio-to-access-preview-versions-feed/

http://docs.nanoframework.net/content/getting-started-guides/build-esp32.html#notes-on-jtag-debugging-on-esp32

https://bintray.com/nfbot/nanoframework-images-dev/

https://bintray.com/nfbot/nanoframework-images-dev/ESP32_WROOM_32/1.4.0-preview.85#files

https://github.com/nanoframework/nf-interpreter#firmware-for-reference-boards

