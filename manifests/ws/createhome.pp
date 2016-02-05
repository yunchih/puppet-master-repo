

class ws::createhome {

	exec { 'createhome':
    		command => '/bin/python2 /root/createhome.py',
    		creates => ['/home/bebi','/home/dept','/home/course','/home/faculty']
  	}

}
