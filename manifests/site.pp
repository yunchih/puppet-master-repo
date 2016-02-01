#hiera_include('classes')

node default {
    include ws::ssh # FixMe   Root login enabled during testing
    include ws::pacman
    include ws::cron
    include ws::nfs
    include ws::ldap
    include ws::fail2ban
    include ws::cups
    include ws::snmp
    include ws::files
    include ws::pkg

#   include ws::iptables
#   include ws::gem
#   include ws::pip

}

node /^war\d+\.csie\.ntu\.edu\.tw/ {

}

node /^peace\d+\.csie\.ntu\.edu\.tw/ {

}
