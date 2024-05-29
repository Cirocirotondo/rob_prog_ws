;; Auto-generated. Do not edit!


(when (boundp 'rfid_sensor::Tag)
  (if (not (find-package "RFID_SENSOR"))
    (make-package "RFID_SENSOR"))
  (shadow 'Tag (find-package "RFID_SENSOR")))
(unless (find-package "RFID_SENSOR::TAG")
  (make-package "RFID_SENSOR::TAG"))

(in-package "ROS")
;;//! \htmlinclude Tag.msg.html


(defclass rfid_sensor::Tag
  :super ros::object
  :slots (_name _dist _phi _rssi ))

(defmethod rfid_sensor::Tag
  (:init
   (&key
    ((:name __name) "")
    ((:dist __dist) 0.0)
    ((:phi __phi) 0.0)
    ((:rssi __rssi) 0.0)
    )
   (send-super :init)
   (setq _name (string __name))
   (setq _dist (float __dist))
   (setq _phi (float __phi))
   (setq _rssi (float __rssi))
   self)
  (:name
   (&optional __name)
   (if __name (setq _name __name)) _name)
  (:dist
   (&optional __dist)
   (if __dist (setq _dist __dist)) _dist)
  (:phi
   (&optional __phi)
   (if __phi (setq _phi __phi)) _phi)
  (:rssi
   (&optional __rssi)
   (if __rssi (setq _rssi __rssi)) _rssi)
  (:serialization-length
   ()
   (+
    ;; string _name
    4 (length _name)
    ;; float64 _dist
    8
    ;; float64 _phi
    8
    ;; float64 _rssi
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _name
       (write-long (length _name) s) (princ _name s)
     ;; float64 _dist
       (sys::poke _dist (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _phi
       (sys::poke _phi (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _rssi
       (sys::poke _rssi (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _name
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _name (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; float64 _dist
     (setq _dist (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _phi
     (setq _phi (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _rssi
     (setq _rssi (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;;
   self)
  )

(setf (get rfid_sensor::Tag :md5sum-) "c42a5846c0bfaa739550f759f2e6e2e0")
(setf (get rfid_sensor::Tag :datatype-) "rfid_sensor/Tag")
(setf (get rfid_sensor::Tag :definition-)
      "# A RFID tag read
string  name
float64 dist
float64 phi
float64 rssi

")



(provide :rfid_sensor/Tag "c42a5846c0bfaa739550f759f2e6e2e0")


