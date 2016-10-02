class ws::cron {
	
	$cron_package = $::operatingsystem ? {
		/(Archlinux|CentOS|RedHat)/	=> 'cronie',
		default				=> 'cron'
	}

	package { $cron_package:
		ensure	=> 'present'
	}

	$crons = [ '/etc/cron.d/', '/etc/cron.daily/']

	$crons.each |$cron| { 
		file { $cron:
			ensure	=> directory,
			recurse	=> remote,
            		notify  => Service[$cron_package],
			owner	=> '0',
			group	=> '0',
			mode	=> '644',
			source	=> "puppet:///$environment/217-base${cron}"
		}
	}

	service { $cron_package:
		ensure	=> 'running'
	}

}


