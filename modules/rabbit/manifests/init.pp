class rabbit { 
   $vm_home = hiera('vm_home')
   $rb_home = hiera('rb_home')
   $rb_sbin = hiera('rb_sbin')
   $rb_tar = hiera('rb_tar')
   $otp_tar = hiera('otp_tar')
   $otp_home = hiera('otp_home')

   # exec { 'erluz':
   #   command => '/bin/tar -xvf ${otp_tar} -C /opt/vmware/',
    # before => Exec['erlconfig'],
    # require => File["${vm_home}/otp_src_R16B.tar.gz"],
   # }
   # exec { 'erlconfig' :
   #    command => '${otp_home}/configure && make && sudo make install',
   #    before => Exec['rabbituz']
   # }
    exec { 'rabbituz':
     command => "/bin/tar -xvf ${rb_tar} -C /opt/vmware/",
     before => Exec['enablemanagement'],
     require => File["${rb_tar}"],
    }
  # file {"${vm_home}/otp_src_R16B.tar.gz":
  #    ensure => file,
  #    owner => root,
  #    mode => '0744',
  #  }
   file {"${rb_tar}":
      ensure => file,
      owner => root,
      mode => '0744',
   }
   exec {'enablemanagement':
      command => "${rb_sbin}/rabbitmq-plugins enable rabbitmq_management",
   }
   service { 'rabsever' :
       ensure => running,
       start => "${rb_sbin}/rabbitmq-server -detached",
       require => Exec['enablemanagement'],
   }
}
