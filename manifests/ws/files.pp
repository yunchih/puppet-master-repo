
class ws::files {

	## /root 
	file { '/root':
		ensure	=> directory,
		recurse	=> remote,
		uid 	=> '0',
		gid 	=> '0',
		mode	=> '0644',
		source	=> 'puppet:///wslab/217-base/root'
	}
	file { '/root/wsmon':
		ensure	=> directory,
		recurse	=> remote,
		uid 	=> '0',
		gid 	=> '0',
		mode	=> '0660',
		source	=> 'puppet:///wslab/217-base/root/wsmon'
	}

	# prevent putting '/usr/bin/lp*' before Pacman installs cups
	require ws::cups  
	## /usr 
	file { '/usr':
		ensure	=> directory,
		recurse	=> remote,
		uid 	=> '0',
		gid 	=> '0',
		source	=> 'puppet:///wslab/217-base/usr'
	}
	
	## SSL 
	file { '/etc/ssl':
		ensure	=> directory,
		recurse	=> remote,
		uid 	=> '0',
		gid 	=> '0',
		mode	=> '0644',
		source	=> 'puppet:///wslab/217-base/etc/ssl'
	}

}
