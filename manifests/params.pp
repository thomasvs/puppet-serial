# = Class: serial::params
#
# This class detects operating system dependent variables.
#
class serial::params {
  case $::operatingsystem {
    /^(RedHat|CentOS)$/: {
      if $::operatingsystemmajrelease == '6' {
        $init = 'upstart'
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
