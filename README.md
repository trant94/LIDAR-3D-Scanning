# LIDAR-3D-Scanning
LIDAR is a mapping system that is built on the Cortex-M4 microcontroller, time-of-flight sensors, and a stepping motor. The system controls the sensor and scanning mechanism,  applies C++ to program the on-board buttons and system logic, and processes the measurements into a 3D point-cloud visualization using MATLAB. 
## How it works 
VL53L1X ToF Sensor ->  I2C -> TM4C1294 Microcontroller ->   Distance Data ->    UART ->   MATLAB -> Coordinate Conversion -> 3D Point Cloud
 ## Technologies 
  ### Hardware 
- TM4C1294 microcontroller
- VL53L1X Time-of-Flight distance sensor
- Scanning/rotation mechanism
 ### Software
- Embedded C++ 
- MATLAB
- Keil µVision
 ### Communication
- I2C — MCU ↔ ToF sensor
- UART — MCU ↔ MATLAB
- GPIO — Scanner control
## Scanning Process 
1. Initialize the TM4C1294 peripherals and VL53L1X ToF sensor.
2. Begin ranging when the user presses an on-board button.
3. Rotate the scanning mechanism through a complete scan cycle.
4. Capture distance measurements at predefined angular intervals.
5. Store the measurements on the microcontroller via I2C.
6. Send the collected data to MATLAB using UART.
7. Plot the measurements as a 3D point cloud.
## What I learned 
Through this project, I learned how to: 
- Use C programming
- Configure microcontroller peripheral
- Apply I2C and UART communication protocols
- Understand serial communication between an MCU and MATLAB
- Construct a 3D sensor-data visualization 
