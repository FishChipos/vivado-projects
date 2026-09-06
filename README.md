# Vivado Projects

## Building the Projects

Vivado and Vitis Unified are used for these projects. The VHDL version used is VHDL-2008.

1. Clone the repository alongside its submodules.

    ```
    git clone --recurse-submodules https://github.com/FishChipos/vivado-projects.git
    ```

2. Just in case, add the `boards/new` directory to the board repository paths and `library` to the default IP repository search paths in Vivado.

3. Open Vivado's TCL console either by itself or through the GUI.

4. Navigate to the `hw` subdirectory of the project you want to build and source the project build script.

    ```
    source project.tcl
    ```

5. The resulting `.xpr` file can then be opened in Vivado.

Any project-specific instructions will be located in their respective directories.
