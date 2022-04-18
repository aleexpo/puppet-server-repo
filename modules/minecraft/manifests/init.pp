class minecraftauto {
  Package { ensure => 'installed' }
  package { 'default-jre': }
  package { 'default-jdk': }
  
  file {'/opt/minecraft':
  ensure => directory,
  }

  include wget
  wget::retrieve { 'https://launcher.mojang.com/v1/objects/bb2b6b1aefcd70dfd1892149ac3a215f6c636b07/server.jar':
  destination => '/opt/minecraft/',
  }

  file { '/etc/systemd/system/minecraft.service':
   ensure => 'file',
   source => 'puppet:///modules/minecraft/service'
  }

  file { '/opt/minecraft/eula.txt':
   ensure => 'file',
   source => 'puppet:///modules/minecraft/eula.txt'
  } 

  service { 'minecraft.service':
  ensure => running,
  enable => true,
  }
}
