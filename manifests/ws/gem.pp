
class ws::gem {
	$gems = hiera("wspkg::gems")

	$agent = $trusted['certname']
	notice( "Gem packages installed to node `${osfamily}::${agent}`:" )
	$gems.each |$gem| { notice( $gem ) }

	package { $gems: 
		ensure => 'latest',
		provider => 'gem'
	}
}
