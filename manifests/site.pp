node 'slave1' {
  file { '/root/README':
   ensure => file, 
  }
  file { '/var/www/sites/static/':
   ensure => directory,
  }
  file {'/var/www/static/':
  ensure => file,
  source => 'puppet:///modules/static/index.html',
  }
  class{'nginx': }
  nginx::resource::server { 'static':
   listen_port => 80,
   proxy       => '192.168.56.9:80',
   #www_root => '/var/www/static/',
  }
}
