# ros-setup

Following the usage instructions in `ros-setup.{zsh, bash}` will do the following:

- Setup ROS
- Setup catkin workspace
- Install UR5 ROS packages

## Launching simulated version of UR5

After the setup is complete, the following commands can be used to test a simulated UR5:

NOTE: You will need running in a GUI session to use the simulators. Run the setup script consistent with your shell.

Multiple terminals will be needed, make sure to `cd ~/ros_ws && source devel/setup.${0}` for each terminal session.

First terminal: `roslaunch ur_gazebo ur5.launch`

Second terminal: `roslaunch ur5_moveit_config ur5_moveit_planning_execution.launch sim:=true`

Third terminal:  `roslaunch ur5_moveit_config moveit_rviz.launch config:=true`

Use the following terminal to subscribe to various topics to see what is being published by running ROS topics.

For example: `rostopic echo /arm_controller/state`

With RViz running, you should be able to drag the end-effector to a random position within
the UR5's workspace. Then from the 'planning' tab, you should be able to plan and execute a path
which will be played back in real-time on both Rviz and the open Gazebo session.


## launch RViz planning on real UR5


First terminal: `roslaunch ur_modern_driver ur5_bringup.launch robot_ip:=ur5`

NOTE: ur5 corresponds to the ip of the robot. If the robot is configured correctly (192.168.1.10), a 'poor man's' DNS will resolve to `ur5`.


Second terminal: `roslaunch ur5_moveit_config ur5_moveit_planning_execution.launch`

Third terminal (for testing with RViz): `roslaunch ur5_moveit_config moveit_rviz.launch config:=true`

NOTE: Make sure you `cd ~/ros_ws && source devel/setup.$0` for each terminal.
We should avoid cluttering PATH with ROS configs until we've figured out how the other subsystems need to be configured (in case python path collision with packages from ROS versus global installation etc.)



