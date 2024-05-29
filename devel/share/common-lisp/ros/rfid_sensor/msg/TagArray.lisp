; Auto-generated. Do not edit!


(cl:in-package rfid_sensor-msg)


;//! \htmlinclude TagArray.msg.html

(cl:defclass <TagArray> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (antennaPose
    :reader antennaPose
    :initarg :antennaPose
    :type geometry_msgs-msg:Pose
    :initform (cl:make-instance 'geometry_msgs-msg:Pose))
   (ntags
    :reader ntags
    :initarg :ntags
    :type cl:integer
    :initform 0)
   (tags
    :reader tags
    :initarg :tags
    :type (cl:vector rfid_sensor-msg:Tag)
   :initform (cl:make-array 0 :element-type 'rfid_sensor-msg:Tag :initial-element (cl:make-instance 'rfid_sensor-msg:Tag))))
)

(cl:defclass TagArray (<TagArray>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <TagArray>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'TagArray)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name rfid_sensor-msg:<TagArray> is deprecated: use rfid_sensor-msg:TagArray instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <TagArray>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rfid_sensor-msg:header-val is deprecated.  Use rfid_sensor-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'antennaPose-val :lambda-list '(m))
(cl:defmethod antennaPose-val ((m <TagArray>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rfid_sensor-msg:antennaPose-val is deprecated.  Use rfid_sensor-msg:antennaPose instead.")
  (antennaPose m))

(cl:ensure-generic-function 'ntags-val :lambda-list '(m))
(cl:defmethod ntags-val ((m <TagArray>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rfid_sensor-msg:ntags-val is deprecated.  Use rfid_sensor-msg:ntags instead.")
  (ntags m))

(cl:ensure-generic-function 'tags-val :lambda-list '(m))
(cl:defmethod tags-val ((m <TagArray>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader rfid_sensor-msg:tags-val is deprecated.  Use rfid_sensor-msg:tags instead.")
  (tags m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <TagArray>) ostream)
  "Serializes a message object of type '<TagArray>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'antennaPose) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'ntags)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'ntags)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'ntags)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'ntags)) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'tags))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'tags))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <TagArray>) istream)
  "Deserializes a message object of type '<TagArray>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'antennaPose) istream)
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'ntags)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'ntags)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'ntags)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'ntags)) (cl:read-byte istream))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'tags) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'tags)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'rfid_sensor-msg:Tag))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<TagArray>)))
  "Returns string type for a message object of type '<TagArray>"
  "rfid_sensor/TagArray")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'TagArray)))
  "Returns string type for a message object of type 'TagArray"
  "rfid_sensor/TagArray")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<TagArray>)))
  "Returns md5sum for a message object of type '<TagArray>"
  "af3038806d5d96b67c9b8bb3b54d8b1b")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'TagArray)))
  "Returns md5sum for a message object of type 'TagArray"
  "af3038806d5d96b67c9b8bb3b54d8b1b")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<TagArray>)))
  "Returns full string definition for message of type '<TagArray>"
  (cl:format cl:nil "# This message contains an array of tags~%~%Header header~%geometry_msgs/Pose antennaPose     	# antenna pose~%uint32 ntags         				# number of tags~%~%# an array of tags~%Tag[] tags~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%================================================================================~%MSG: rfid_sensor/Tag~%# A RFID tag read~%string  name~%float64 dist~%float64 phi~%float64 rssi~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'TagArray)))
  "Returns full string definition for message of type 'TagArray"
  (cl:format cl:nil "# This message contains an array of tags~%~%Header header~%geometry_msgs/Pose antennaPose     	# antenna pose~%uint32 ntags         				# number of tags~%~%# an array of tags~%Tag[] tags~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%================================================================================~%MSG: rfid_sensor/Tag~%# A RFID tag read~%string  name~%float64 dist~%float64 phi~%float64 rssi~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <TagArray>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'antennaPose))
     4
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'tags) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <TagArray>))
  "Converts a ROS message object to a list"
  (cl:list 'TagArray
    (cl:cons ':header (header msg))
    (cl:cons ':antennaPose (antennaPose msg))
    (cl:cons ':ntags (ntags msg))
    (cl:cons ':tags (tags msg))
))
