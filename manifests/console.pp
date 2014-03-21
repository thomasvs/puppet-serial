# = Class: serial::console
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
define serial::console (
  $baud = '115200',
) {

  serial::console::service { $name: }
  serial::console::config { $name:
      baud => $baud
  }

}
