default['torquebox']['version']="2.3.0"
default['torquebox']['source_url']="http://torquebox.org/release/org/torquebox/torquebox-dist/#{torquebox['version']}/torquebox-dist-#{torquebox['version']}-bin.zip"
default['torquebox']['user'] = 'torquebox'
default['torquebox']['group'] = 'torquebx'
default['torquebox']['checksums'] = {
    "2.3.0" => "5cf43eac0394ee8dad83ada922c927a33da085588f7275cb0934560dbde8e101"
}
default['torquebox']['install_path'] = "/usr/local/torquebox"
default['torquebox']['dist_home'] = "/opt"

default['torquebox']['pid_file'] = "/var/run/torquebox/torquebox.pid"

default['torquebox']['log_file'] = "/var/log/torquebox/torquebox.log"
default['torquebox']['system_log_file'] = "/var/log/torquebox/system.log"
default['torquebox']['boot_log_file'] = "/var/log/torquebox/boot.log"


# our vagrant VM external address
default['torquebox']['listen_address'] = '192.168.4.3'
default['torquebox']['mgmt_address'] = '192.168.4.3'
