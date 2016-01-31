class ws::cron {
	
	$cron_package = $::operatingsystem ? {
		/(Archlinux|CentOS|RedHat)/	=> 'cronie',
		default				=> 'cron'
	}

	package { $cron_package:
		ensure	=> 'present'
	}

	service { $cron_package:
		ensure	=> 'running'
	}

	$crons = [ '/etc/cron.d/', '/etc/cron.daily/', '/etc/cron.hourly']

	$crons.each |$cron| { 
		file { $cron:
			ensure	=> directory,
			recurse	=> remote,
			owner	=> 'root',
			group	=> 'root',
			mode	=> '644',
			source	=> "puppet:///wslab/217-base${cron}"
		}
	}

}


