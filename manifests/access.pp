define access::access (
  $permission,
  $entity     = $title,
  $origin,
  $ensure     = present,
  $priority   = '10'
) {
  include access

  if ! ($::osfamily in ['Debian', 'RedHat', 'Suse']) {
    fail("access::access does not support osfamily $::osfamily")
  }

  if ! ($permission in ['+', '-']) {
    fail("Permission must be + or - ; recieved $permission")
  }

  realize Concat['/etc/security/access.conf']

  concat::fragment { "access::access $permission$entity$origin":
    ensure  => $ensure,
    target  => '/etc/security/access.conf',
    content => "${permission}:${entity}:${origin}\n",
    order   => $priority,
  }

}
