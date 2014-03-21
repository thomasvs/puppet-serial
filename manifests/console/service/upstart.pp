# = define serial::console::service::upstart
#
# This define manages an upstart-based service for a serial console
#
# [* name *]
#   The name of the serial console; e.g. ttyS1
#
define serial::console::service::upstart {
  service { $name:
    ensure     => running,
    hasstatus  => false,
    hasrestart => false,
    start      => "/sbin/initctl start ${name}",
    stop       => "/sbin/initctl stop ${name}",
    status     => "/sbin/initctl status ${name} | grep ^'${name} start/running' 1>/dev/null 2>&1",
    require    => Serial::Console::Config[$name],
  }
}
