class access::access_wrapper (
#$admins = $access::params::admins, 
#$interactive=$access::params::interactive 
$otherusers = $acess::params::otherusers
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
 $users = any2array( $otherusers ) 
# adduser { $users : priority => 25 }
}
