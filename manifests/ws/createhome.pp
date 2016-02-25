

class ws::createhome {
    
	exec { 'createhome':
    		command => '/usr/bin/env python2 /root/createhome.py',
    		creates => ['/home/bebi','/home/dept','/home/course','/home/faculty','/home/student','/home/master','/home/phd','/home/inm']
  	}

}
