#!/bin/bash

# VisualMicro needs to have compiled project at least once to find binary files in C:\Users\\$WINDOWS_USER\AppData\Local\...

if grep -q Microsoft /proc/version; then
  # WSL format command

  WINDOWS_USER=$(cmd.exe /c "echo %USERNAME%")  # get the host username which may be different from WSL
  WINDOWS_USER=${WINDOWS_USER//[$'\t\r\n']}     # trim any cr/lf chars

  # be sure to launch from something other than linux WSL VoIFS filesystem (TODO why does upload fail otherwise?)
  cd /mnt/c/Users/$WINDOWS_USER

  # Brain teaser: when calling Windows executable from WSL, use Windows path (C:\...), not WSL (/mnt/c/...) for parameters
  /mnt/c/Users/$WINDOWS_USER/AppData/Local/arduino15/packages/esp32/tools/esptool_py/2.6.0/esptool.exe \
     --chip esp32                     \
     --port COM13                     \
     --baud 921600                    \
     --before default_reset           \
     --after hard_reset write_flash   \
     -z --flash_mode dio              \
     --flash_freq 80m                 \
     --flash_size detect              \
     0xe000  "C:\Users\\$WINDOWS_USER\AppData\Local\arduino15\packages\esp32\hardware\esp32\1.0.1\tools\partitions\boot_app0.bin"        \
     0x1000  "C:\Users\\$WINDOWS_USER\AppData\Local\arduino15\packages\esp32\hardware\esp32\1.0.1\tools\sdk\bin\bootloader_qio_80m.bin"  \
     0x10000 "C:\Users\\$WINDOWS_USER\AppData\Local\Temp\VMBuilds\VISUAL~1\ESP32_~1\Release\VisualMicro.ino.bin"                         \
     0x8000  "C:\Users\\$WINDOWS_USER\AppData\Local\Temp\VMBuilds\VISUAL~1\ESP32_~1\Release\VisualMicro.ino.partitions.bin"
else
  echo "real linux upload not implemented; where would the Windows-compiled VisualMicro files be?"
  # TODO real linux
fi
