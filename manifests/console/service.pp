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
  case $::operatingsystem {
    /^(RedHat|CentOS)$/: {
      if $::operatingsystemmajrelease == '6' {
        serial::console::service::upstart { $name: }
      } else {
        fail('Unsupported RedHat/CentOS version')
      }
    }
    default: {
      # FIXME: can we detect upstart and use it?
      fail('Unsupported operating system')
    }
  }

}
