python ..\bin\ESP32\esptool.py --chip esp32 --port "COM13" --baud 921600 --before "default_reset" --after "hard_reset" write_flash -z --flash_mode "dio" --flash_freq "40m" --flash_size detect 0x1000 bin\bootloader.bin 0x10000 bin\nanoCLR.bin 0x8000 bin\partitions_4mb.bin"

