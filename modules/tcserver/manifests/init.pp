class tcserver {
    
   $vm_home = hiera('vm_home')
   $tc_zipfile = hiera('tc_zipfile')
   $tc_home = hiera('tc_home')
   $tc_bin = hiera('tc_bin')
   exec { 'uz':
     command => "/usr/bin/unzip ${tc_zipfile} -d /opt/vmware",
     before => Exec['tcinstance'],
     require => File["${vm_home}/vfabric-tc-server-standard-2.9.2.RELEASE.zip"],
    }
   file {"${vm_home}/vfabric-tc-server-standard-2.9.2.RELEASE.zip":
      ensure => file,
      owner => root,
      mode => '0744',
   }
   exec { 'tcinstance':
      command => "${tc_home}/tcruntime-instance.sh create -i ${tc_home} myinstance"
      
    }
   service { 'tcruntime-ctl.sh':
       ensure => running,
       start => "${tc_bin}/tcruntime-ctl.sh start",
       require => Exec['tcinstance'],
   }
 }
