# BIND Module

The **BIND** module handles the installation, running and configuration of 
the [bind](#bind) dns server.

This module was tested on RedHat 6.3.

## Configuration

Here we give a list of available configuration parameters to override in Hiera:

`bind_package_name` is the name of the OS package for squid, this shouldn't need changing. The default value is 'bind'.

`bind_data_dir` is path for the BIND 'data' directory

`bind_config_file` is the path to BIND's main config file.

`bind_config_dir` is the path to BIND's configuration directory. This primarily preserves the operating system's default directory for BIND.

`bind_group_name` is the name of the primary group that BIND's deamon runs under.

`bind_querylog` is the path to the file which logs all queries to this instance of BIND.


## Dependencies

This module depends on the following modules:

## Caveats

* This module is not supported or tested on Ubuntu

## References

* [**BIND**](id:bind) http://www.isc.org/downloads/bind/


