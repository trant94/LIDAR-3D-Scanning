# LIDAR-3D-Scanning
LIDAR is a mapping system that is built on the Cortex-M4 microcontroller, time-of-flight sensors, and a stepping motor. The system controls the sensor and scanning mechanism,  applies C++ to program the on-board buttons and system logic, and processes the measurements into a 3D point-cloud visualization using MATLAB. 
## How it works 
VL53L1X ToF Sensor ->  I2C -> TM4C1294 Microcontroller ->   Distance Data ->    UART ->   MATLAB -> Coordinate Conversion -> 3D Point Cloud
  ## Technologies 
  ### Hardware 
-TM4C1294 microcontroller
- VL53L1X Time-of-Flight distance sensor
- Scanning/rotation mechanism
  ### Software
- Embedded C++ 
- MATLAB
- Keil µVision
- ### Communication
- I2C — MCU ↔ ToF sensor
- UART — MCU ↔ MATLAB
- GPIO — Scanner control
