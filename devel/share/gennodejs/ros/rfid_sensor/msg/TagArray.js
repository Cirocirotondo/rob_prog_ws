// Auto-generated. Do not edit!

// (in-package rfid_sensor.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let Tag = require('./Tag.js');
let std_msgs = _finder('std_msgs');
let geometry_msgs = _finder('geometry_msgs');

//-----------------------------------------------------------

class TagArray {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.antennaPose = null;
      this.ntags = null;
      this.tags = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('antennaPose')) {
        this.antennaPose = initObj.antennaPose
      }
      else {
        this.antennaPose = new geometry_msgs.msg.Pose();
      }
      if (initObj.hasOwnProperty('ntags')) {
        this.ntags = initObj.ntags
      }
      else {
        this.ntags = 0;
      }
      if (initObj.hasOwnProperty('tags')) {
        this.tags = initObj.tags
      }
      else {
        this.tags = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type TagArray
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [antennaPose]
    bufferOffset = geometry_msgs.msg.Pose.serialize(obj.antennaPose, buffer, bufferOffset);
    // Serialize message field [ntags]
    bufferOffset = _serializer.uint32(obj.ntags, buffer, bufferOffset);
    // Serialize message field [tags]
    // Serialize the length for message field [tags]
    bufferOffset = _serializer.uint32(obj.tags.length, buffer, bufferOffset);
    obj.tags.forEach((val) => {
      bufferOffset = Tag.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type TagArray
    let len;
    let data = new TagArray(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [antennaPose]
    data.antennaPose = geometry_msgs.msg.Pose.deserialize(buffer, bufferOffset);
    // Deserialize message field [ntags]
    data.ntags = _deserializer.uint32(buffer, bufferOffset);
    // Deserialize message field [tags]
    // Deserialize array length for message field [tags]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.tags = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.tags[i] = Tag.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    object.tags.forEach((val) => {
      length += Tag.getMessageSize(val);
    });
    return length + 64;
  }

  static datatype() {
    // Returns string type for a message object
    return 'rfid_sensor/TagArray';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'af3038806d5d96b67c9b8bb3b54d8b1b';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # This message contains an array of tags
    
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
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new TagArray(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.antennaPose !== undefined) {
      resolved.antennaPose = geometry_msgs.msg.Pose.Resolve(msg.antennaPose)
    }
    else {
      resolved.antennaPose = new geometry_msgs.msg.Pose()
    }

    if (msg.ntags !== undefined) {
      resolved.ntags = msg.ntags;
    }
    else {
      resolved.ntags = 0
    }

    if (msg.tags !== undefined) {
      resolved.tags = new Array(msg.tags.length);
      for (let i = 0; i < resolved.tags.length; ++i) {
        resolved.tags[i] = Tag.Resolve(msg.tags[i]);
      }
    }
    else {
      resolved.tags = []
    }

    return resolved;
    }
};

module.exports = TagArray;
