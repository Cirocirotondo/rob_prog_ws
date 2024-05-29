// Generated by gencpp from file rfid_sensor/Tag.msg
// DO NOT EDIT!


#ifndef RFID_SENSOR_MESSAGE_TAG_H
#define RFID_SENSOR_MESSAGE_TAG_H


#include <string>
#include <vector>
#include <memory>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>


namespace rfid_sensor
{
template <class ContainerAllocator>
struct Tag_
{
  typedef Tag_<ContainerAllocator> Type;

  Tag_()
    : name()
    , dist(0.0)
    , phi(0.0)
    , rssi(0.0)  {
    }
  Tag_(const ContainerAllocator& _alloc)
    : name(_alloc)
    , dist(0.0)
    , phi(0.0)
    , rssi(0.0)  {
  (void)_alloc;
    }



   typedef std::basic_string<char, std::char_traits<char>, typename std::allocator_traits<ContainerAllocator>::template rebind_alloc<char>> _name_type;
  _name_type name;

   typedef double _dist_type;
  _dist_type dist;

   typedef double _phi_type;
  _phi_type phi;

   typedef double _rssi_type;
  _rssi_type rssi;





  typedef boost::shared_ptr< ::rfid_sensor::Tag_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::rfid_sensor::Tag_<ContainerAllocator> const> ConstPtr;

}; // struct Tag_

typedef ::rfid_sensor::Tag_<std::allocator<void> > Tag;

typedef boost::shared_ptr< ::rfid_sensor::Tag > TagPtr;
typedef boost::shared_ptr< ::rfid_sensor::Tag const> TagConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::rfid_sensor::Tag_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::rfid_sensor::Tag_<ContainerAllocator> >::stream(s, "", v);
return s;
}


template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator==(const ::rfid_sensor::Tag_<ContainerAllocator1> & lhs, const ::rfid_sensor::Tag_<ContainerAllocator2> & rhs)
{
  return lhs.name == rhs.name &&
    lhs.dist == rhs.dist &&
    lhs.phi == rhs.phi &&
    lhs.rssi == rhs.rssi;
}

template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator!=(const ::rfid_sensor::Tag_<ContainerAllocator1> & lhs, const ::rfid_sensor::Tag_<ContainerAllocator2> & rhs)
{
  return !(lhs == rhs);
}


} // namespace rfid_sensor

namespace ros
{
namespace message_traits
{





template <class ContainerAllocator>
struct IsMessage< ::rfid_sensor::Tag_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::rfid_sensor::Tag_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::rfid_sensor::Tag_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::rfid_sensor::Tag_<ContainerAllocator> const>
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::rfid_sensor::Tag_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::rfid_sensor::Tag_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::rfid_sensor::Tag_<ContainerAllocator> >
{
  static const char* value()
  {
    return "c42a5846c0bfaa739550f759f2e6e2e0";
  }

  static const char* value(const ::rfid_sensor::Tag_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0xc42a5846c0bfaa73ULL;
  static const uint64_t static_value2 = 0x9550f759f2e6e2e0ULL;
};

template<class ContainerAllocator>
struct DataType< ::rfid_sensor::Tag_<ContainerAllocator> >
{
  static const char* value()
  {
    return "rfid_sensor/Tag";
  }

  static const char* value(const ::rfid_sensor::Tag_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::rfid_sensor::Tag_<ContainerAllocator> >
{
  static const char* value()
  {
    return "# A RFID tag read\n"
"string  name\n"
"float64 dist\n"
"float64 phi\n"
"float64 rssi\n"
;
  }

  static const char* value(const ::rfid_sensor::Tag_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::rfid_sensor::Tag_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.name);
      stream.next(m.dist);
      stream.next(m.phi);
      stream.next(m.rssi);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct Tag_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::rfid_sensor::Tag_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::rfid_sensor::Tag_<ContainerAllocator>& v)
  {
    s << indent << "name: ";
    Printer<std::basic_string<char, std::char_traits<char>, typename std::allocator_traits<ContainerAllocator>::template rebind_alloc<char>>>::stream(s, indent + "  ", v.name);
    s << indent << "dist: ";
    Printer<double>::stream(s, indent + "  ", v.dist);
    s << indent << "phi: ";
    Printer<double>::stream(s, indent + "  ", v.phi);
    s << indent << "rssi: ";
    Printer<double>::stream(s, indent + "  ", v.rssi);
  }
};

} // namespace message_operations
} // namespace ros

#endif // RFID_SENSOR_MESSAGE_TAG_H
