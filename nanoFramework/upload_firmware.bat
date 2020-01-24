@echo off
if "%1" == "" goto NO_COM

@echo on
python ..\bin\ESP32\esptool.py --chip esp32 --port "%1" --baud 921600 --before "default_reset" --after "hard_reset" write_flash -z --flash_mode "dio" --flash_freq "40m" --flash_size detect 0x1000 bin\bootloader.bin 0x10000 bin\nanoCLR.bin 0x8000 bin\partitions_4mb.bin"
@echo off

goto done

:NO_COM
echo error: no COM port specified. example: upload_firmware.bat COM13

:done

