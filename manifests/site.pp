
node slave1 {
   file { '/root/README':
   ensure => file, }
}

node slave2 {
   file { '/root/README':
   ensure => file, }
}

node slave1 {
  package { 'nginx' :
  ensure => installed,
   }

  file { :
   path => '/etc/nginx/sites-available/static.conf'
   ensure => present,
   name => 'conf', 
   source => 'puppet:///modules/static/servconf/static.conf',
   }

  file { '/var/www/sites/static/index.html':
   ensure => directory,
   source => 'puppet:///modules/static/index.html',
   recurse => true,
   }

  file { '/etc/nginx/sites-available/static.conf':
   ensure => 'link',
   name => 'link',
   target => '/etc/nginx/sites-enabled/',
   }

  ~> service { 'nginx':
   ensure => running,
   enable => true,
   }
}

#node slave2 {
   #package {'nginx', 'php-fpm', 'php-mysql', 'php':
   #
   #}
