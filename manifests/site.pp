
node default {
    include ws::ssh
    include ws::pacman
    include ws::at
    include ws::cron
    include ws::createhome
    include ws::logrotate
    include ws::nfs
    include ws::ldap
    include ws::nscd
    include ws::fail2ban
    include ws::cups
    include ws::snmp
    include ws::tmp2
    include ws::ipsec
    include ws::sudo
    include ws::matlab
    include ws::munin
    include ws::iptables
    include ws::ulogd
    include ws::mail
    include ws::munin
    include ws::files
    include ws::pkg

#   include ws::audit
#   include ws::gem
#   include ws::pip

}

