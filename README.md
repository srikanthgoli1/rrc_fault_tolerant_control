# motor_fault_sim_dataset

| Vehicle Type | Frame | Frame Type | Filename
| ----------- | ----------- | ----------- | ----------- |
| Quadcopter | <img src="images/quadplus.png" width="200"/> | Plus | M1 [bin](dist/quad-plus/m1.bin) [mat](dist/quad-plus/m1.mat) <br> M2 [bin](dist/quad-plus/m2.bin) [mat](dist/quad-plus/m2.mat)<br> M3 [bin](dist/quad-plus/m3.bin) [mat](dist/quad-plus/m3.mat)<br> M4 [bin](dist/quad-plus/m4.bin) [mat](dist/quad-plus/m4.mat)<br> M1 & M2 [bin](dist/quad-plus/m1m2.bin) [mat](dist/quad-plus/m1m2.mat)<br> M1 & M3 [bin](dist/quad-plus/m1m3.bin) [mat](dist/quad-plus/m1m3.mat)<br> M1 & M4 [bin](dist/quad-plus/m1m4.bin) [mat](dist/quad-plus/m1m4.mat)<br> M2 & M3 [bin](dist/quad-plus/m2m3.bin) [mat](dist/quad-plus/m2m3.mat)<br> M2 & M4 [bin](dist/quad-plus/m2m4.bin) [mat](dist/quad-plus/m2m4.mat)<br> M3 & M4 [bin](dist/quad-plus/m3m4.bin) [mat](dist/quad-plus/m3m4.mat)
| Quadcopter | <img src="images/quadx.png" width="200"/> | X | M1 [bin](dist/quad-x/m1.bin) [mat](dist/quad-x/m1.mat) <br> M2 [bin](dist/quad-x/m2.bin) [mat](dist/quad-x/m2.mat)<br> M3 [bin](dist/quad-x/m3.bin) [mat](dist/quad-x/m3.mat)<br> M4 [bin](dist/quad-x/m4.bin) [mat](dist/quad-x/m4.mat)<br> M1 & M2 [bin](dist/quad-x/m1m2.bin) [mat](dist/quad-x/m1m2.mat)<br> M1 & M3 [bin](dist/quad-x/m1m3.bin) [mat](dist/quad-x/m1m3.mat)<br> M1 & M4 [bin](dist/quad-x/m1m4.bin) [mat](dist/quad-x/m1m4.mat)<br> M2 & M3 [bin](dist/quad-x/m2m3.bin) [mat](dist/quad-x/m2m3.mat)<br> M2 & M4 [bin](dist/quad-x/m2m4.bin) [mat](dist/quad-x/m2m4.mat)<br> M3 & M4 [bin](dist/quad-x/m3m4.bin) [mat](dist/quad-x/m3m4.mat)
| Hexacopter | <img src="images/hexaplus.png" width="200"/> | Plus | M1 [bin](dist/hexa-plus/m1.bin) [mat](dist/hexa-plus/m1.mat)<br> M2 [bin](dist/hexa-plus/m1.bin) [mat](dist/hexa-plus/m1.mat)<br> M3 [bin](dist/hexa-plus/m1.bin) [mat](dist/hexa-plus/m1.mat)<br> M4 [bin](dist/hexa-plus/m1.bin) [mat](dist/hexa-plus/m1.mat)<br> M5 [bin](dist/hexa-plus/m1.bin) [mat](dist/hexa-plus/m1.mat)<br> M6 [bin](dist/hexa-plus/m1.bin) [mat](dist/hexa-plus/m1.mat)<br> M1 & M2 [bin](dist/hexa-plus/m1.bin) [mat](dist/hexa-plus/m1.mat)<br> M1 & M3 [bin](dist/hexa-plus/m1.bin) [mat](dist/hexa-plus/m1.mat)<br> M1 & M4 [bin](dist/hexa-plus/m1.bin) [mat](dist/hexa-plus/m1.mat)<br> M1 & M5 [bin](dist/hexa-plus/m1.bin) [mat](dist/hexa-plus/m1.mat)<br> M1 & M6 [bin](dist/hexa-plus/m1.bin) [mat](dist/hexa-plus/m1.mat)<br> M2 & M3 [bin](dist/hexa-plus/m1.bin) [mat](dist/hexa-plus/m1.mat)<br> M2 & M4 [bin](dist/hexa-plus/m1.bin) [mat](dist/hexa-plus/m1.mat)<br> M2 & M5 [bin](dist/hexa-plus/m1.bin) [mat](dist/hexa-plus/m1.mat)<br> M2 & M6 [bin](dist/hexa-plus/m1.bin) [mat](dist/hexa-plus/m1.mat)<br> M3 & M4 [bin](dist/hexa-plus/m1.bin) [mat](dist/hexa-plus/m1.mat)<br> M3 & M5 [bin](dist/hexa-plus/m1.bin) [mat](dist/hexa-plus/m1.mat)<br> M3 & M6 [bin](dist/hexa-plus/m1.bin) [mat](dist/hexa-plus/m1.mat)<br> M4 & M5 [bin](dist/hexa-plus/m1.bin) [mat](dist/hexa-plus/m1.mat)<br> M4 & M6 [bin](dist/hexa-plus/m1.bin) [mat](dist/hexa-plus/m1.mat)<br> M5 & M6 [bin](dist/hexa-plus/m1.bin) [mat](dist/hexa-plus/m1.mat)
| Hexacopter | <img src="images/hexax.png" width="200"/> | X | M1<br> M2<br> M3<br> M4<br> M5<br> M6<br> M1 & M2<br> M1 & M3<br> M1 & M4<br> M1 & M5<br> M1 & M6<br> M2 & M3<br> M2 & M4<br> M2 & M5<br> M2 & M6<br> M3 & M4<br> M3 & M5<br> M3 & M6<br> M4 & M5<br> M4 & M6<br> M5 & M6



## Sample data

- X-Frame QuadCopter is used
- [15:47:15] Drone starts ascent
- [15:47:55] Goes up to altitude of 100meters
- [15:48:00] Fault introduced in motor 2 (from code)
- Immediately starts descent
- [15:48:15] Crash lands in 15-16 seconds

### Barometer
![](images/100m/Barometer.png)

### Gyroscope
![](images/100m/Gyro_1.png)

### Roll, Pitch, Yaw
![](images/100m/Euler_Roll.png)
![](images/100m/Euler_Pitch.png)
![](images/100m/Euler_Yaw.png)

### Servo outputs
![](images/100m/Servos_1-4.png)