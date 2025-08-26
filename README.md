# Heater Zone Simulations
A MATLAB-based simulation framework designed to model the thermal behavior of industrial extruder heater zones. The purpose of this project is to enable offline PID tuning and system analysis without requiring direct access to the physical machine.

# DISCLAIMER:
This repository contains code that was originally developed using proprietary machine data and auxiliary scripts (e.g., SQL exports).
These files cannot be provided due to data access restrictions. As a result, not all functionality in the simulation scripts will run as intended.

The included code is intended for demonstration and reference purposes only. Users may adapt the framework by substituting their own process data or parameters in place of the missing files.

# What to run: 
Under "Heater Simulations", I recommend looking at Zone1_MATLAB.mlx first. This Live script will cover what the project is objectively about. The next one to look over is the AllZones.m script. This script is basically the full version of how we would want to tune across all zones in the system, but for now it is a skeleton until it can be further refined. 

The scripts located under "System Identification Testing" are more so used to highlight my thought process with how to use the System Identification Toolbox (this is not a finalized process and will be reviewed in the future). The scripts under this folder also require some additional files that I cannot provide, therefore functionality will be limited.

# Code Explanation(s):

  - Heater Simulations:
    - Zone1_MATLAB.mlx: A live script that experiments with the first zone in the extruder system. This script contains many comments and explanations. It is NOT finalized, but rather a foundation for the project in the future.
    - AllZones.m: A script that incorporates all zones in the extruder system. For the time being this is experimental, but this will serve as the final foundation when tuning multiple zones at once.

  - Sytstem Identification Testing:
    - DataAllocation.m: A script that pulls the data of the system from a .xlsx file in the SQL server. This reads the data and stores it respectively into a table within MATLAB.
    - TransferFuncEst.m: This script performs system identification on Zone 1 of the extruder heater system using MATLAB’s System Identification Toolbox.
    - Zone1_SIDTB_Experimentation.m: A script that utilizes the results of the System Identification Toolbox for the plant model. Code is similar to Zone1_MATLAB.mlx.

# Key Features:
- Implemented a first-order heater model to replicate zone temperature dynamics.
- Simulated open-loop and closed-loop responses using Siemens-style PID algorithms.
- Integrated real machine data collected from SQL servers to refine plant transfer functions via MATLAB’s System Identification Toolbox (began doing this, but other job priorities diverted focus).
- Explored 2-DOF PID structures (Kp, Ti, Td, a, b, c parameters) for realistic tuning.
- Provides a flexible testbed for experimenting with parameter scaling, proportional weighting, and inter-zone heat transfer.
- Designed to reduce machine downtime by improving the accuracy of PID parameter selection.

# Ran With
- MATLAB R2024
- Toolboxes:
  - Control System Toolbox (transfer functions, `step`, `feedback`)
  - System Identification Toolbox (for `tfest`, `iddata`, `compare`) — only needed for identification scripts
  - Symbolic Math Toolbox (for `tf('s)`)

# License
This project is licensed under the MIT License – see the [LICENSE](LICENSE) file for details.


