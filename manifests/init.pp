class bind(
    $package_name  = 'bind',
    $data_dir      = '/var/named',
    $config_file   = '/etc/named.conf',
    $config_dir    = '/etc/named',
    $group_name    = 'named',
    $querylog_file = '/var/log/bind.querylog',
) {

    package { 'bind':
        name => $package_name,
        ensure => present,
    }

    group { 'bind':
        name    => $group_name,
        ensure  => present,
        require => Package['bind'],
        # best to let the package take care of this
    }

    file {  'bind.dir':
        path    => $config_dir,
        ensure  => directory,
        owner   => 'root',
        group   => $group_name,
        mode    => '0750',
        require => Package['bind'],
    }

    file { 'bind.conf':
        path    => $config_file,
        ensure  => present,
        content => template("bind/named.conf.erb"),
        mode    => '0640',
        owner   => 'root',
        group   => $group_name,
        require => Group['bind'],
    }

    service { 'named':
        ensure  => running,
        enable  => true,
        require => [ Package['bind'], File['bind.conf']],
    }

    file { 'querylog':
        path    => $querylog_file,
        ensure  => present,
        owner   => 'root',
        group   => $group_name,
        mode    => '660',
        require => Group['bind'],
    }

}
