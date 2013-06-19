class sqlfire {

     $vm_home = hiera('vm_home')
     $sqlf_zipfile = hiera('tc_zipfile')

   exec { 'uz':
     command => '/usr/bin/unzip ${tc_zipfile} -d /opt/vmware',
     before => Exec['mkdir1'],
     require => File['/opt/vmware/vFabric_SQLFire_11_b40332.zip'],
    }
   file {"${vm_home}e/vFabric_SQLFire_11_b40332.zip":
      ensure => file,
      owner => root,
      mode => '0744', 
   }

 
 }
