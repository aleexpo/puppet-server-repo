


node 'slave2' {
   file { '/root/README':
   ensure => file, }
}

node 'slave1' {
   file { '/root/README':
   ensure => file, }


  package { 'nginx' :
  ensure => installed,
   }

  file { 'copy static':
   ensure => present,
   path => '/etc/nginx/sites-available/static.conf',
   source => 'puppet:///modules/servconf/static.conf',
   }

  file { '/var/www/sites/static/index.html':
   ensure => present,
   source => 'puppet:///modules/static/index.html',
   recurse => true,
   }

  file { '/etc/nginx/sites-available/static.conf':
   ensure => 'link',
   name => 'link',
   target => '/etc/nginx/sites-enabled/static.conf',
   }

   service { 'nginx':
   ensure => running,
   enable => true,
   }
}

#node slave2 {
   #package {'nginx', 'php-fpm', 'php-mysql', 'php':
   #
   #}
