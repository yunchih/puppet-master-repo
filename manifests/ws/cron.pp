class ws::cron {
	
	$cron_package = $::operatingsystem ? {
		/(Archlinux|CentOS|RedHat)/	=> 'cronie',
		default				=> 'cron'
	}

	package { $cron_package:
		ensure	=> 'present'
	}

	$crons = [ '/etc/cron.d/', '/etc/cron.daily/', '/etc/cron.hourly']

	$crons.each |$cron| { 
		file { $cron:
			ensure	=> directory,
			recurse	=> remote,
            uid 	=> '0',
            gid 	=> '0',
			mode	=> '644',
			source	=> "puppet:///wslab/217-base${cron}"
		}
	}

	service { $cron_package:
		ensure	=> 'running'
	}

}


