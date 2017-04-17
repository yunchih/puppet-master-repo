
class base {
    include ws::pkg_manager
    include ws::files
}

class home {
    include ws::createhome
    include ws::nfs

    Class['ws::nfs'] -> Class['ws::createhome']
}

class monitor {
    include ws::snmp
    include ws::munin
}

class auth {
    include ws::ipsec
    include ws::ldap
    include ws::sssd

     Class['ws::ipsec'] -> Class['ws::sssd'] -> Class['ws::ldap']
}

class services {
    include ws::ssh
    include ws::mail
    include ws::cups
    include ws::systemd
    include home
}

class firewall {
    include ws::iptables
    include ws::fail2ban

    Class['ws::iptables'] -> Class['ws::fail2ban']
}

class utilities {
    include ws::at
    include ws::logrotate
    include ws::ulogd
    include ws::cron
    include ws::tmp2
    include ws::sudo
}

class packages {
    include ws::matlab
    include ws::pkg
}

stage { "ws::main": }
stage { "ws::pre": }
stage { "ws::post": }

Stage["ws::pre"] -> Stage["ws::main"] -> Stage["ws::post"]

node default {
    Class {"base":      stage => "ws::pre", }
    Class {"auth":      stage => "ws::main", }
    Class {"home":      stage => "ws::main", }
    Class {"firewall":  stage => "ws::main", }
    Class {"monitor":   stage => "ws::main", }
    Class {"utilities": stage => "ws::main", }
    Class {"services":  stage => "ws::main", }
    Class {"packages":  stage => "ws::post", }
}

