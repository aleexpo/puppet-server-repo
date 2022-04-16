node 'slave1' {
  file { '/root/README':
   ensure => file, 
  }
  file { '/var/www/sites/static/index.html':
   ensure => file,
   source => 'puppet:///modules/static/index.html',
   recurse => true,
  }
  -> class{'nginx': }
  -> nginx::resource::server { 'static':
   listen_port => 80,
   proxy       => '192.168.56.9:80',
   #www_root => '/var/www/static/',
  }
}
