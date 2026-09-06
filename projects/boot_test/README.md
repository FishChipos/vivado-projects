## Boot Test

### Boot Image Creation

1. Open the project in Vivado and generate a bitstream.

2. Go to "File" > "Export" > "Export Hardware...".

3. Select "Include bitstream/binary" and tick "Include bitstream".

4. Name the `.xsa` file anything you want. Put it in a separate folder called `.../boot_test/sw`.

5. Open Vitis Unified and set the workspace to `.../boot_test/sw`.

6. Go to "File" > "New Component" > "Platform".

7. Name the platform anything you want. Select the `.xsa` file from earlier as the hardware design then create the platform.

8. Wait for the platform to finish being created then go to "File" > "New Example" and choose the "Hello World" application.

9. Name the application anything you want. Select the platform created earlier then finish creating the application.

10. In the "Flow" panel on the bottom left, build the project by clicking "Build". If it asks, choose to generate the platform alongside the application.

11. Now click "Create Boot Image". The output filenames should be set to `BOOT.bif` and `BOOT.bin`.

### Using the Boot Images

#### Boot from SD

1. Prepare a SD/SDHC card.

2. Format the card to FAT32.

3. Copy the `BOOT.bin` file to it.

4. Plug the card into the Zybo Z7's SD card slot.

5. Move the boot jumper to the SD position.

#### Boot from QSPI Flash

1. Move the boot jumper to the JTAG position.

2. Connect the Zybo Z7 to your computer.

3. Choose the `BOOT.bin` file as the image.

4. Click "Program" to program the Zybo Z7.

5. Move the boot jumper to the QSPI position and power cycle the Zybo Z7.
