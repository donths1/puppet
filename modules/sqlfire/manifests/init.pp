class sqlfire {

     $vm_home = hiera('vm_home')
     $sqlf_zipfile = hiera('tc_zipfile')

   exec { 'uz':
     command => '/usr/bin/unzip ${tc_zipfile} -d /opt/vmware',
     before => Exec['mkdir1'],
     require => File[{"${sqlf_zipfile}"],
    }
   file {"${sqlf_zipfile}":
      ensure => file,
      owner => root,
      mode => '0744', 
   }

 
 }
