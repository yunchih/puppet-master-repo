
class ws::matlab {
	
	file { '/usr/bin/matlab':
		ensure	=> 'link',
		target	=> '/usr/local/matlab/bin/matlab'
	}	

	file { '/usr/local/matlab':
		ensure	=> 'link',
		target	=> '/nfs/linux/matlab'
	}	

	$license_server = hiera("ws::matlab::license_server")
	if $trusted['certname'] in $license_server  {
        file { '/etc/systemd/system/matlab-lm.service':
            owner	=> 0,
            group	=> 0,
            mode	=> '0644',
            source  => "puppet:///wslab/217-base/etc/systemd/system/matlab-lm.service"
        }
    }

	service { "matlab-lm":
		ensure	=> 'running'
	}
}
