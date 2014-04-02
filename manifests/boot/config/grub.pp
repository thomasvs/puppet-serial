# = define serial::boot::config::grub
#
# This define manages grub-based config for a serial boot console
#
# [* name *]
#   The name of the serial console; e.g. ttyS1
#
# [* baud *]
#   The baud/speed of the serial console; defaults to 115200
#
# [* timeout *]
#   The number of times grub tries to determine whether keyboard or serial
#   console is the main output
#
define serial::boot::config::grub (
  $baud = '115200',
  $timeout = 3,
) {

  $config = '/boot/grub/grub.conf'
  $console = "console=${name},${baud}"
  $unit = regsubst($name, '^ttyS(\d)$', '\1')


  $perl = '/usr/bin/perl'
  $sed = '/bin/sed'
  $grep = '/bin/grep'
  $grubby = '/sbin/grubby'
  $bash = '/bin/bash'

  exec { 'grub-disable-splash-image':
    command => "${perl} -i -p -e 's@^splashimage@# splashimage@' ${config}",
    unless  => "${grep} '# splashimage' ${config}",
  }

  # putting serial first means that by default, if no key is touched during
  # grub's timeout for console checking, all output after kernel loading
  # and before login console also goes to serial
  $args = "'console=${console} console=tty0'"
  exec { 'grub-kernel-add-console':
    command => "${grubby} --grub --update-kernel=ALL --args=${args}",
    # FIXME: I wish I could chain two greps so I could only do this on
    #        the lines starting with kernel
    unless  => "${grep} ${args} ${config}",
  }

  exec { 'grub-add-serial':
    command => "${sed} -i '1iserial --unit=${unit} --speed=${baud}' ${config}",
    unless  => "${grep} 'serial --unit' ${config}",
  }
  $serial = "serial --unit=${unit} --speed=${baud}"
  exec { 'grub-replace-serial':
    command => "${perl} -i -p -e 's@^serial=.*$@${serial}@' ${config}",
    unless  => "${grep} -E '^${serial}' ${config}",
    require => Exec['grub-add-serial'],
  }

  $tm = "--timeout-${timeout}"
  exec { 'grub-add-terminal':
    command => "${sed} -i '2iterminal ${tm} console serial' ${config}",
    unless  => "${grep} '${tm}' ${config}",
  }
}
