
class ws::matlab {
	
	file { '/usr/bin/matlab':
		ensure	=> 'link',
		target	=> '/usr/local/matlab/bin/matlab'
	}	

	file { '/usr/local/matlab':
		ensure	=> 'link',
		target	=> '/nfs/linux/matlab'
	}	

	package { "ncurses5-compat-libs":
		ensure	=> 'present'
	}

	$license_server = hiera("ws::matlab::license_server")
	if $trusted['certname'] in $license_server  {
        file { '/etc/systemd/system/matlab-lm.service':
            owner	=> 0,
            group	=> 0,
            mode	=> '0644',
            source  => "puppet:///$environment/217-base/etc/systemd/system/matlab-lm.service"
        }

        # matlab-lm.service will be deemed 'failed' by SystemD
        # afte it completes forking.  If set as "ensure => 'running'",
        # Puppet will try to kill the lm and restart it.
        service { "matlab-lm":
            ensure  => undef,
            enable	=> 'true'
        }

        file { ['/usr/tmp', '/var/tmp']:
            ensure  => directory
        }
    }

}
