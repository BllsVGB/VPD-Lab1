#!/usr/bin/env python3
import ev3dev2.motor as motor
import time


motorA = motor.LargeMotor(motor.OUTPUT_A)
volt = [100, 80, 60, 40, 20, -20, -40, -60, -80, -100]
for vol in volt :
    time_start = time.time()  
    start_position = motorA.position  
    with open( 'name{}.txt'.format(vol), 'w') as f:
        while True:
            time_now = time.time() - time_start
            motorA.run_direct(duty_cycle_sp=vol)
            pos = motorA.position - start_position
            f.write('{} {} {}\n'.format(time_now, pos, motorA.speed))

            if time_now > 5:
                motorA.run_direct(duty_cycle_sp=0)
                motorA.stop(stop_action = 'brake')
                time.sleep(5)
                break


