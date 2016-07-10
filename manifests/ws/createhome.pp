

class ws::createhome {
    
    file { "/root/createhome.py":
        ensure	=> file,
        mode	=> '0744',
        source	=> "puppet:///wslab/217-base/root/createhome.py"
    }

	exec { 'createhome':
    		command => '/usr/bin/env python2 /root/createhome.py',
    		creates => ['/home/bebi','/home/dept','/home/course','/home/faculty','/home/student','/home/master','/home/phd','/home/inm']
  	}

}
