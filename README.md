A MATLAB-based simulation framework designed to model the thermal behavior of industrial extruder heater zones. The purpose of this project is to enable offline PID tuning and system analysis without requiring direct access to the physical machine.

Key Features:

- Implemented a first-order heater model to replicate zone temperature dynamics.
- Simulated open-loop and closed-loop responses using Siemens-style PID algorithms.
- Integrated real machine data collected from SQL servers to refine plant transfer functions via MATLAB’s System Identification Toolbox (began doing this, but other job priorities diverted focus).
- Explored 2-DOF PID structures (Kp, Ti, Td, a, b, c parameters) for realistic tuning.
- Provides a flexible testbed for experimenting with parameter scaling, proportional weighting, and inter-zone heat transfer.
- Designed to reduce machine downtime by improving the accuracy of PID parameter selection.

Toolboxes: Control System Toolbox, System Identification Toolbox, Symbolic Math Toolbox
