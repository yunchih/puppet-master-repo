
class ws::polkit {

	package { 'polkit':
		ensure	=> 'present'
	} ->

	file { '/etc/polkit-1/rules.d':
        owner	=> 0,
        group	=> 'polkitd',
		ensure	=> directory,
		recurse	=> remote,
        source  => "puppet:///$environment/217-base/etc/polkit-1/rules.d",
        require => Package['polkit']
	}

}
