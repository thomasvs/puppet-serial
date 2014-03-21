# = define serial::console::config::upstart
#
# This define manages an upstart-based config for a serial console
#
# [* name *]
#   The name of the serial console; e.g. ttyS1
#
define serial::console::config::upstart {
  notify { "config::upstart for ${name}": }
}
