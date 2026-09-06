# Vivado Projects

## Building the Projects

Vivado and Vitis Unified are used for this project.

1. Clone the repository alongside its submodules.

    ```
    git clone --recurse-submodules https://github.com/FishChipos/vivado-projects.git
    ```

2. Open Vivado's TCL console either by itself or through the GUI.

3. Navigate to the `hw` subdirectory of the project you want to build and source the project build script.

    ```
    source project.tcl
    ```

4. The resulting `.xpr` file can then be opened in Vivado.

Any project-specific instructions will be located in their respective directories.
