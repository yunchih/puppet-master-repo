node default {
    include ws::ssh 
    include ws::pacman
    include ws::cron
    include ws::nfs
    include ws::ldap
    include ws::fail2ban
    include ws::cups
    include ws::snmp
    include ws::files
    include ws::tmp2
    include ws::ipsec
    include ws::pkg

#   include ws::iptables
#   include ws::gem
#   include ws::pip

}

