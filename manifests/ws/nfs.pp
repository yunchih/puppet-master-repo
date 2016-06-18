class ws::nfs {
	
	$nfs_package = $::operatingsystem ? {
		/(Archlinux)/		=> ['nfs-utils', 'autofs'],
		default			=> 'nfs-common'
	}
	$nfs_service = $::operatingsystem ? {
		"Archlinux"	=> ['rpcbind.service','nfs-client.target','remote-fs.target', 'autofs'],
		"FreeBSD"	=> ['nfsclient']
	}
	package { $nfs_package:
		ensure	=> 'latest'
	}

	file { [ '/etc/autofs','/etc/autofs/auto.master.d']:
		ensure	=> directory,
		owner	=> '0',
		group	=> '0',
		mode	=> '644',
	}

	$autos = [ 
		'auto.master.d/backup.autofs', 
		'auto.master.d/ntucsp.autofs', 
		'auto.master',
		'auto.nfs',
		'auto.backup'
	]

	$autos.each |$auto| { 
		file { "/etc/autofs/$auto":
			ensure	=> file,
			owner	=> '0',
			group	=> '0',
			mode	=> '644',
			source	=> "puppet:///wslab/217-base/etc/${auto}"
		}
	}

	service { $nfs_service:
		ensure	=> 'running'
	}

	$base_links = ['bebi','course','dept','faculty']	

	$base_links.each |$link| { 
		file { "/home/${link}":
			ensure	=> link,
			target	=> "/nfs/${link}"
		}
	}

	$links = {
		"student"	=> "undergrad",
		"master"	=> "master",
		"phd"		=> "phd",
		"inm/master"	=> "inm_master",
		"inm/phd"	=> "inm_phd"
	}

	$years = ['00','01','02','03','04']

	$links.each |$link| { 
		$from = $link[0]
		$to   = $link[1]	
		$years.each |$year| { 
			file { "/home/${from}/${year}":
				ensure	=> link,
				target	=> "/nfs/${to}/${year}"
			}
		}
	}
}


