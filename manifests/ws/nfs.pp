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
		ensure	=> 'present'
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
		'auto.backup'
	]

	$autos.each |$auto| { 
		file { "/etc/autofs/$auto":
			ensure	=> file,
			owner	=> '0',
			group	=> '0',
			mode	=> '644',
			source	=> "puppet:///$environment/217-base/etc/${auto}"
		}
	}

 	file { "/etc/autofs/auto.nfs":
 		ensure	=> file,
 		owner	=> '0',
 		group	=> '0',
 		mode	=> '755',
 		source	=> "puppet:///$environment/217-base/etc/auto.nfs"
 	}
 
	service { $nfs_service:
		ensure	=> 'running',
        enable  => true
	}

}


