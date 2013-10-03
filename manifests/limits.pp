define access::limits (
  $domain,
  $type,
  $item,
  $value,
  $ensure   = present,
  $priority = '10'
) {
  include access

  if ! ($osfamily in ['Debian', 'RedHat', 'Suse']) {
    fail("access::limits does not support osfamily $osfamily")
  }

  realize Concat['/etc/security/limits.conf']

  concat::fragment { "access::limits ${domain}-${type}-${item}-${value}":
    ensure  => $ensure,
    target  => '/etc/security/limits.conf',
    content => "${domain} ${type} ${item} ${value}\n",
    order   => $priority,
  }

}
