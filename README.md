A MATLAB-based simulation framework designed to model the thermal behavior of industrial extruder heater zones. The purpose of this project is to enable offline PID tuning and system analysis without requiring direct access to the physical machine.

DISCLAIMER:
This repository contains code that was originally developed using proprietary machine data and auxiliary scripts (e.g., SQL exports).
These files cannot be provided due to data access restrictions. As a result, not all functionality in the simulation scripts will run as intended.

The included code is intended for demonstration and reference purposes only. Users may adapt the framework by substituting their own process data or parameters in place of the missing files.

Code Explanation(s):

  - Heater Simulations:

        Zone1_MATLAB.mlx: A live script that experiemnts with the first zone in the extruder system. This script contains many comments and explanations. It is NOT finalized, but rather a foundation for the project in the future.

  
        AllZones.m: A script that incorporates all zones in the extruder system. For the time being this is experimental, but this will serve as the final foundation when tuning multiple zones at once.

  - Sytstem Identification Testing:
  
        DataAllocation.m: A script that pulls the data of the system from a .xslx in the SQL server. This reads the data and stores it respectively into a table within matlab.

        TransferFuncEst.m: This script performs system identification on Zone 1 of the extruder heater system using MATLAB’s System Identification Toolbox.

        Zone1_SIDTB_Experimentation: A script that utilizes the results of the Sys ID Toolbox for the plant model. Code is similar to 'Zone1_MATLAB.mlx'


Key Features:

- Implemented a first-order heater model to replicate zone temperature dynamics.
- Simulated open-loop and closed-loop responses using Siemens-style PID algorithms.
- Integrated real machine data collected from SQL servers to refine plant transfer functions via MATLAB’s System Identification Toolbox (began doing this, but other job priorities diverted focus).
- Explored 2-DOF PID structures (Kp, Ti, Td, a, b, c parameters) for realistic tuning.
- Provides a flexible testbed for experimenting with parameter scaling, proportional weighting, and inter-zone heat transfer.
- Designed to reduce machine downtime by improving the accuracy of PID parameter selection.

Toolboxes: Control System Toolbox, System Identification Toolbox, Symbolic Math Toolbox
