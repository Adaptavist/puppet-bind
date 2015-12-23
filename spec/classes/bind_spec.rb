	require 'spec_helper'
 
describe 'bind', :type => 'class' do
  
  def_package_name = 'bind'
  def_data_dir = '/var/named'
  def_config_file = '/etc/named.conf'
  def_config_dir = '/etc/named'
  def_group_name = 'named'
  def_querylog_file = '/var/log/bind.querylog'

  package_name = 'bindd'
  data_dir = '/var/namedd'
  config_file = '/etc/named.conff'
  config_dir = '/etc/namedd'
  group_name = 'namedd'
  querylog_file = '/var/log/bind.querylogg'

  def check_values(package_name, data_dir, config_file, config_dir, group_name, querylog_file)
     should contain_group('bind').with_ensure('present').that_requires("Package[bind]").with(
        'name'  => group_name,
      )
     
      should contain_package('bind').with_ensure('present').with(
          'name' => package_name,
        ).that_comes_before("Service[named]")

      should contain_service('named').with(
        'ensure'  => 'running',
        'enable'  => true,
        'require' =>["Package[bind]", "File[bind.conf]"],
        )

      ['bind.dir', 'bind.conf', 'querylog'].each do |file|
        should contain_file(file).with(
          'owner' => 'root',
          'group' => group_name,
          )
      end

      should contain_file('bind.dir').with(
        'path'    => config_dir,
        'ensure'  => "directory",
        'mode'    => '0750',
        'require' => 'Package[bind]',
      )

      should contain_file('bind.conf').with(
        'path'    => config_file,
        'ensure'  => 'present',
        # 'content' => template("bind/named.conf.erb"),
        'require' => 'Group[bind]',
      )

      should contain_file('querylog').with(
        'path'    => querylog_file,
        'ensure'  => 'present',
        'mode'    => '660',
        'require' => 'Group[bind]',
      )
    end

  context "Should install package, create group, config files and run service with default params" do
    it { 
      check_values(def_package_name, def_data_dir, def_config_file, def_config_dir, def_group_name, def_querylog_file)
    }
  end

  context "Should install package, create group, config files and run service with passed params" do
    let :params do
      {
        :package_name  => package_name,
        :data_dir      => data_dir,
        :config_file   => config_file,
        :config_dir    => config_dir,
        :group_name    => group_name,  
        :querylog_file => querylog_file,
      }
    end
    it do
      check_values(package_name, data_dir, config_file, config_dir, group_name, querylog_file)
    end
  end

end
