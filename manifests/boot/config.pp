# = Class: serial::boot::config
#
# This class updates boot configuration for a serial console.
#
define serial::boot::config (
  $baud = '115200',
) {
  include serial::params

  case $serial::params::boot {
    'grub': {
      serial::boot::config::grub { $name:
        baud => $baud,
      }
    }
    default: {
      fail('Unsupported boot system')
    }
  }

}
