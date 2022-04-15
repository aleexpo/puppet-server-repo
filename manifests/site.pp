
node default {
   file { '/root/README':
   ensure => file, }
}

node slave1 {
  package { 'nginx' :
  ensure => installed,
   }

  -> file { '/etc/nginx/sites-available/static':
   ensure => file, 
   source => 'puppet:///modules/static/servconf/config',
   }

  -> file { '/var/www/sites/static/index.html':
   ensure => directory,
   source => 'puppet:///modules/static/index.html',
   recurse => true,
   }

  -> file { '/etc/nginx/sites-available/static':
   ensure => 'link',
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
