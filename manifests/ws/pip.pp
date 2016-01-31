
class ws::pip {

	require ws::pkg

	$pip = hiera("wspkg::pip")
	
	$agent = $trusted['certname']
	notice( "Pip packages installed to node `${osfamily}::${agent}`:" )
	$pip.each |$pkg| {
		notice( $pkg ) 
		pip::install { $pkg:
			package	=> $pkg,
			ensure	=> 'latest',
		}
	}
}
