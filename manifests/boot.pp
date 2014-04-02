# = Class: serial::boot
#
define serial::boot (
  $baud = '115200',
) {

  serial::boot::config { $name:
      baud => $baud
  }

}
