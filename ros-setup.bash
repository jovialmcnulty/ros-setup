#!/usr/bin/env bash
#purpose: setup ROS Kinetic Kame for Ubuntu 16.04 with bash
#usage: ./ros-setup.bash
#author: Joe Cloud, git@joe.cloud

CATKIN_WS=~/ros_ws
CATKIN_SHELL=bash

echo "Installing ROS Kinetic..."
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116


sudo apt-get update
sudo apt-get install ros-kinetic-desktop-full -y

sudo rosdep init
rosdep update

echo "Adding ROS Shell setup to ${CATKIN_SHELL}rc"
echo "source /opt/ros/kinetic/setup.${CATKIN_SHELL}" >> ~/.${CATKIN_SHELL}rc

. /opt/ros/kinetic/setup.${CATKIN_SHELL}

echo "Installing additional ROS tools..."
sudo apt-get install python-rosinstall python-rosinstall-generator python-wstool build-essential -y
sudo apt-get install git-core python-argparse python-vcstools python-rosdep \ 
        ros-kinetic-control-msgs ros-kinetic-joystick-drivers ros-kinetic-xacro \
        ros-kinetic-tf2-ros ros-kinetic-rviz ros-kinetic-cv-bridge ros-kinetic-actionlib \
        ros-kinetic-actionlib-msgs ros-kinetic-dynamic-reconfigure ros-kinetic-trajectory-msgs
        ros-kinetic-rospy-message-converter -y

sudo apt-get install ros-kinetic-universal-robot -y

echo "Making catkin workspace in directory: ${CATKIN_WS}"

mkdir -p ${CATKIN_WS}/src
cd ${CATKIN_WS}
catkin_make

cd src
wstool init .
git clone -b kinetic-devel https://github.com/ros-industrial/universal_robot.git
cd ..
rosdep update
rosdep install --from-paths src --ignore-src --rosdistro kinetic
catkin_make

sudo apt-get install ros-kinetic-ur-gazebo ros-kinetic-ur5-moveit-config ros-kinetic-ur-kinematics -y 

echo "Make sure to source devel/setup.${CATKIN_SHELL} from ${CATKIN_WS}"

