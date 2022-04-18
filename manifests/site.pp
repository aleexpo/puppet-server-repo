node 'slave1' {
  file { '/root/README':
   ensure => 'absent', 
  }

  class { 'apache': }

  -> file {'/var/www/html/index.html':
  ensure => 'file',
  source => 'puppet:///modules/static/index.html',
  }

  -> apache::vhost { 'static':
  port          => '80',
  docroot       => '/var/www/html',
  }

}

node 'slave2' {
  file { '/root/README':
   ensure => 'absent', 
  }

  class { 'apache': }
  Package { ensure => 'installed' }
  package { 'php': }
  package { 'libapache2-mod-php': }
  package { 'php-mysql': }
  package { 'mariadb-server': }
  
  -> file { '/var/www/php':
  ensure => 'directory',
  }

  -> file {'/var/www/php/index.html':
  ensure => 'file',
  source => 'puppet:///modules/dynamic/index.php',
  }

  -> apache::vhost { 'dynamic':
  port          => '81',
  docroot       => '/var/www/php',
  }

}

node 'master.puppet' {
  include nginx

  file { '/etc/nginx/conf.d/default.conf':
   ensure => 'file',
   source => 'puppet:///modules/dynamic/default.conf'
  }
  nginx::resource::server { 'static':
   listen_port => 80,
   proxy       => 'http://192.168.56.9:80',
  }
  nginx::resource::server { 'dynamic':
   listen_port => 81,
   proxy       => 'http://192.168.56.10:81',
  }
}


node 'mineserver.puppet'{
  class {'minecraftauto':}
} 
