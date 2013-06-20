class tcserver {
    
   $vm_home = hiera('vm_home')
   $tc_zipfile = hiera('tc_zipfile')
   $tc_home = hiera('tc_home')
   $tc_bin = hiera('tc_bin')
   $tc_instance = hiera('tc_instance')
   exec { 'uz':
     command => "/usr/bin/unzip ${tc_zipfile} -d ${vm_home}",
     before => Exec['tcinstance'],
     require => File["${tc_zipfile}"],
    }
   file {"${tc_zipfile}":
      ensure => file,
      owner => root,
      mode => '0744',
   }
   exec { 'tcinstance':
      command => "${tc_home}/tcruntime-instance.sh create -i ${tc_home} ${tc_instance}"
      
    }
   service { 'tcruntime-ctl.sh':
       ensure => running,
       start => "${tc_bin}/tcruntime-ctl.sh start",
       require => Exec['tcinstance'],
   }
 }
