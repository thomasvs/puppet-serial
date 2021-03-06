# = Class: serial::console::service
#
# This class does stuff that you describe here.
# Change Class to Define if needed.
#
# == Requirements:
#
# - This module requires
#
# == Parameters
#
# [* ensure *]
#   What state to ensure for the module.
#   Default: present
#
# == Variables
#
# == Examples
#
# == Author
#
define serial::console::service {
  include serial::params

  case $serial::params::init {
    'upstart': {
        serial::console::service::upstart { $name: }
    }
    default: {
      fail('Unsupported init system')
    }
  }

}
