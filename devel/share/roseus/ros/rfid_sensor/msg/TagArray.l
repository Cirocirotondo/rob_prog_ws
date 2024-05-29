;; Auto-generated. Do not edit!


(when (boundp 'rfid_sensor::TagArray)
  (if (not (find-package "RFID_SENSOR"))
    (make-package "RFID_SENSOR"))
  (shadow 'TagArray (find-package "RFID_SENSOR")))
(unless (find-package "RFID_SENSOR::TAGARRAY")
  (make-package "RFID_SENSOR::TAGARRAY"))

(in-package "ROS")
;;//! \htmlinclude TagArray.msg.html
(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass rfid_sensor::TagArray
  :super ros::object
  :slots (_header _antennaPose _ntags _tags ))

(defmethod rfid_sensor::TagArray
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:antennaPose __antennaPose) (instance geometry_msgs::Pose :init))
    ((:ntags __ntags) 0)
    ((:tags __tags) ())
    )
   (send-super :init)
   (setq _header __header)
   (setq _antennaPose __antennaPose)
   (setq _ntags (round __ntags))
   (setq _tags __tags)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:antennaPose
   (&rest __antennaPose)
   (if (keywordp (car __antennaPose))
       (send* _antennaPose __antennaPose)
     (progn
       (if __antennaPose (setq _antennaPose (car __antennaPose)))
       _antennaPose)))
  (:ntags
   (&optional __ntags)
   (if __ntags (setq _ntags __ntags)) _ntags)
  (:tags
   (&rest __tags)
   (if (keywordp (car __tags))
       (send* _tags __tags)
     (progn
       (if __tags (setq _tags (car __tags)))
       _tags)))
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; geometry_msgs/Pose _antennaPose
    (send _antennaPose :serialization-length)
    ;; uint32 _ntags
    4
    ;; rfid_sensor/Tag[] _tags
    (apply #'+ (send-all _tags :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; geometry_msgs/Pose _antennaPose
       (send _antennaPose :serialize s)
     ;; uint32 _ntags
       (write-long _ntags s)
     ;; rfid_sensor/Tag[] _tags
     (write-long (length _tags) s)
     (dolist (elem _tags)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; geometry_msgs/Pose _antennaPose
     (send _antennaPose :deserialize buf ptr-) (incf ptr- (send _antennaPose :serialization-length))
   ;; uint32 _ntags
     (setq _ntags (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; rfid_sensor/Tag[] _tags
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _tags (let (r) (dotimes (i n) (push (instance rfid_sensor::Tag :init) r)) r))
     (dolist (elem- _tags)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get rfid_sensor::TagArray :md5sum-) "af3038806d5d96b67c9b8bb3b54d8b1b")
(setf (get rfid_sensor::TagArray :datatype-) "rfid_sensor/TagArray")
(setf (get rfid_sensor::TagArray :definition-)
      "# This message contains an array of tags

Header header
geometry_msgs/Pose antennaPose     	# antenna pose
uint32 ntags         				# number of tags

# an array of tags
Tag[] tags

================================================================================
MSG: std_msgs/Header
# Standard metadata for higher-level stamped data types.
# This is generally used to communicate timestamped data 
# in a particular coordinate frame.
# 
# sequence ID: consecutively increasing ID 
uint32 seq
#Two-integer timestamp that is expressed as:
# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
# time-handling sugar is provided by the client library
time stamp
#Frame this data is associated with
string frame_id

================================================================================
MSG: geometry_msgs/Pose
# A representation of pose in free space, composed of position and orientation. 
Point position
Quaternion orientation

================================================================================
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z

================================================================================
MSG: geometry_msgs/Quaternion
# This represents an orientation in free space in quaternion form.

float64 x
float64 y
float64 z
float64 w

================================================================================
MSG: rfid_sensor/Tag
# A RFID tag read
string  name
float64 dist
float64 phi
float64 rssi

")



(provide :rfid_sensor/TagArray "af3038806d5d96b67c9b8bb3b54d8b1b")


