# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "rfid_sensor: 2 messages, 0 services")

set(MSG_I_FLAGS "-Irfid_sensor:/home/simone/ROS/rob_prog_ws/src/rfid_sensor/msg;-Istd_msgs:/opt/ros/noetic/share/std_msgs/cmake/../msg;-Igeometry_msgs:/opt/ros/noetic/share/geometry_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(rfid_sensor_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/simone/ROS/rob_prog_ws/src/rfid_sensor/msg/Tag.msg" NAME_WE)
add_custom_target(_rfid_sensor_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "rfid_sensor" "/home/simone/ROS/rob_prog_ws/src/rfid_sensor/msg/Tag.msg" ""
)

get_filename_component(_filename "/home/simone/ROS/rob_prog_ws/src/rfid_sensor/msg/TagArray.msg" NAME_WE)
add_custom_target(_rfid_sensor_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "rfid_sensor" "/home/simone/ROS/rob_prog_ws/src/rfid_sensor/msg/TagArray.msg" "rfid_sensor/Tag:geometry_msgs/Quaternion:std_msgs/Header:geometry_msgs/Point:geometry_msgs/Pose"
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(rfid_sensor
  "/home/simone/ROS/rob_prog_ws/src/rfid_sensor/msg/Tag.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/rfid_sensor
)
_generate_msg_cpp(rfid_sensor
  "/home/simone/ROS/rob_prog_ws/src/rfid_sensor/msg/TagArray.msg"
  "${MSG_I_FLAGS}"
  "/home/simone/ROS/rob_prog_ws/src/rfid_sensor/msg/Tag.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/rfid_sensor
)

### Generating Services

### Generating Module File
_generate_module_cpp(rfid_sensor
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/rfid_sensor
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(rfid_sensor_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(rfid_sensor_generate_messages rfid_sensor_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/simone/ROS/rob_prog_ws/src/rfid_sensor/msg/Tag.msg" NAME_WE)
add_dependencies(rfid_sensor_generate_messages_cpp _rfid_sensor_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/simone/ROS/rob_prog_ws/src/rfid_sensor/msg/TagArray.msg" NAME_WE)
add_dependencies(rfid_sensor_generate_messages_cpp _rfid_sensor_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(rfid_sensor_gencpp)
add_dependencies(rfid_sensor_gencpp rfid_sensor_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS rfid_sensor_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages
_generate_msg_eus(rfid_sensor
  "/home/simone/ROS/rob_prog_ws/src/rfid_sensor/msg/Tag.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/rfid_sensor
)
_generate_msg_eus(rfid_sensor
  "/home/simone/ROS/rob_prog_ws/src/rfid_sensor/msg/TagArray.msg"
  "${MSG_I_FLAGS}"
  "/home/simone/ROS/rob_prog_ws/src/rfid_sensor/msg/Tag.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/rfid_sensor
)

### Generating Services

### Generating Module File
_generate_module_eus(rfid_sensor
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/rfid_sensor
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(rfid_sensor_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(rfid_sensor_generate_messages rfid_sensor_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/simone/ROS/rob_prog_ws/src/rfid_sensor/msg/Tag.msg" NAME_WE)
add_dependencies(rfid_sensor_generate_messages_eus _rfid_sensor_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/simone/ROS/rob_prog_ws/src/rfid_sensor/msg/TagArray.msg" NAME_WE)
add_dependencies(rfid_sensor_generate_messages_eus _rfid_sensor_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(rfid_sensor_geneus)
add_dependencies(rfid_sensor_geneus rfid_sensor_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS rfid_sensor_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(rfid_sensor
  "/home/simone/ROS/rob_prog_ws/src/rfid_sensor/msg/Tag.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/rfid_sensor
)
_generate_msg_lisp(rfid_sensor
  "/home/simone/ROS/rob_prog_ws/src/rfid_sensor/msg/TagArray.msg"
  "${MSG_I_FLAGS}"
  "/home/simone/ROS/rob_prog_ws/src/rfid_sensor/msg/Tag.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/rfid_sensor
)

### Generating Services

### Generating Module File
_generate_module_lisp(rfid_sensor
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/rfid_sensor
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(rfid_sensor_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(rfid_sensor_generate_messages rfid_sensor_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/simone/ROS/rob_prog_ws/src/rfid_sensor/msg/Tag.msg" NAME_WE)
add_dependencies(rfid_sensor_generate_messages_lisp _rfid_sensor_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/simone/ROS/rob_prog_ws/src/rfid_sensor/msg/TagArray.msg" NAME_WE)
add_dependencies(rfid_sensor_generate_messages_lisp _rfid_sensor_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(rfid_sensor_genlisp)
add_dependencies(rfid_sensor_genlisp rfid_sensor_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS rfid_sensor_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages
_generate_msg_nodejs(rfid_sensor
  "/home/simone/ROS/rob_prog_ws/src/rfid_sensor/msg/Tag.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/rfid_sensor
)
_generate_msg_nodejs(rfid_sensor
  "/home/simone/ROS/rob_prog_ws/src/rfid_sensor/msg/TagArray.msg"
  "${MSG_I_FLAGS}"
  "/home/simone/ROS/rob_prog_ws/src/rfid_sensor/msg/Tag.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/rfid_sensor
)

### Generating Services

### Generating Module File
_generate_module_nodejs(rfid_sensor
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/rfid_sensor
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(rfid_sensor_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(rfid_sensor_generate_messages rfid_sensor_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/simone/ROS/rob_prog_ws/src/rfid_sensor/msg/Tag.msg" NAME_WE)
add_dependencies(rfid_sensor_generate_messages_nodejs _rfid_sensor_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/simone/ROS/rob_prog_ws/src/rfid_sensor/msg/TagArray.msg" NAME_WE)
add_dependencies(rfid_sensor_generate_messages_nodejs _rfid_sensor_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(rfid_sensor_gennodejs)
add_dependencies(rfid_sensor_gennodejs rfid_sensor_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS rfid_sensor_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(rfid_sensor
  "/home/simone/ROS/rob_prog_ws/src/rfid_sensor/msg/Tag.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/rfid_sensor
)
_generate_msg_py(rfid_sensor
  "/home/simone/ROS/rob_prog_ws/src/rfid_sensor/msg/TagArray.msg"
  "${MSG_I_FLAGS}"
  "/home/simone/ROS/rob_prog_ws/src/rfid_sensor/msg/Tag.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/rfid_sensor
)

### Generating Services

### Generating Module File
_generate_module_py(rfid_sensor
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/rfid_sensor
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(rfid_sensor_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(rfid_sensor_generate_messages rfid_sensor_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/simone/ROS/rob_prog_ws/src/rfid_sensor/msg/Tag.msg" NAME_WE)
add_dependencies(rfid_sensor_generate_messages_py _rfid_sensor_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/simone/ROS/rob_prog_ws/src/rfid_sensor/msg/TagArray.msg" NAME_WE)
add_dependencies(rfid_sensor_generate_messages_py _rfid_sensor_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(rfid_sensor_genpy)
add_dependencies(rfid_sensor_genpy rfid_sensor_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS rfid_sensor_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/rfid_sensor)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/rfid_sensor
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(rfid_sensor_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()
if(TARGET geometry_msgs_generate_messages_cpp)
  add_dependencies(rfid_sensor_generate_messages_cpp geometry_msgs_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/rfid_sensor)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/rfid_sensor
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_eus)
  add_dependencies(rfid_sensor_generate_messages_eus std_msgs_generate_messages_eus)
endif()
if(TARGET geometry_msgs_generate_messages_eus)
  add_dependencies(rfid_sensor_generate_messages_eus geometry_msgs_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/rfid_sensor)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/rfid_sensor
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_lisp)
  add_dependencies(rfid_sensor_generate_messages_lisp std_msgs_generate_messages_lisp)
endif()
if(TARGET geometry_msgs_generate_messages_lisp)
  add_dependencies(rfid_sensor_generate_messages_lisp geometry_msgs_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/rfid_sensor)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/rfid_sensor
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_nodejs)
  add_dependencies(rfid_sensor_generate_messages_nodejs std_msgs_generate_messages_nodejs)
endif()
if(TARGET geometry_msgs_generate_messages_nodejs)
  add_dependencies(rfid_sensor_generate_messages_nodejs geometry_msgs_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/rfid_sensor)
  install(CODE "execute_process(COMMAND \"/usr/bin/python3\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/rfid_sensor\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/rfid_sensor
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(rfid_sensor_generate_messages_py std_msgs_generate_messages_py)
endif()
if(TARGET geometry_msgs_generate_messages_py)
  add_dependencies(rfid_sensor_generate_messages_py geometry_msgs_generate_messages_py)
endif()
