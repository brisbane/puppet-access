class access::access_wrapper (
#$admins = $access::params::admins, 
#$interactive=$access::params::interactive 
	) inherits access::params
{

#addsudoer { $admins :}
adduser { $admins :} 
adduser { root :}
define blockuser ($priority = 20)
{
access::access {
   $name :
    permission  => "-",
    entity      => $name,
    origin      => "ALL",
    priority    => $priority
}
}
define adduser ($priority = 20 ) 
{
access::access { 
   $name :
    permission  => "+",
    entity      => $name,
    origin      => "ALL",
    priority    => $priority
}
}

if $interactive == true {
        adduser { ["ALL"] : priority => 30}
     }
     else  { 
	blockuser { ["ALL"] : priority => 30}
     }

 if ! ($osfamily in ['RedHat']) {
    fail("access::access_wrapper does not support osfamily $osfamily")
  }
  else
  {
  #Not that secret, but can give a few things away
   file { '/etc/pam.d/system-auth':
         ensure =>present,
         source  => "puppet:///$secretsfilepath/pam.d.system-auth",
         owner   => 'root',
         group   => 'root',
         mode    => '0444',
  }
   file { '/etc/pam.d/password-auth':
         ensure =>present,
         source  => "puppet:///$secretsfilepath/pam.d.system-auth",
         owner   => 'root',
         group   => 'root',
         mode    => '0444',
  }
 } 


}
