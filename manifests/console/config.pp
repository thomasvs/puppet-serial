# = Class: serial::console::config
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
define serial::console::config (
  $baud = '115200',
) {
  include serial::params

  case $serial::params::init {
    'upstart': {
      serial::console::config::upstart { $name:
        baud => $baud,
      }
    }
    default: {
      fail('Unsupported init system')
    }
  }

}
