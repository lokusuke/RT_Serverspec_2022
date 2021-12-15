require 'spec_helper'


#####Rubyに必要なパッケージがインストールされているか確認#####
%w{ git gcc-c++ make patch curl libcurl-devel libffi-devel libyaml-devel libicu-devel libxml2-devel libxslt-devel nginx mysql-community-client }.each do |pkg|
  describe package(pkg) do
    it { should be_installed }
  end
end   

%w{ rails bundler }.each do |pkg|
  describe package(pkg) do
    it { should be_installed.by('gem') }
  end
end

#####指定したサービスが起動しているか確認#####
describe service('nginx') do
  it { should be_enabled }
  it { should be_running }
end

describe service('sshd') do
  it { should be_enabled }
  it { should be_running }
end

#####指定したプロセスが起動しているか確認#####
describe process('nginx') do
  it { should be_running }
 end

#####指定したコマンドの実行が正常に行われているか確認#####
describe command('ruby -v') do
  its(:stdout) { should match /ruby 2\.6\.3/ }
end

describe command('rails -v') do
  its(:stdout) { should match /Rails 6\.0\.4\.1/ }
end

describe command('cat /etc/nginx/conf.d/rails_study.conf') do
  its(:stdout) { should match /server_name \${Private_IP};/ }
end

describe command('curl http://127.0.0.1:80/ -o /dev/null -w "%{http_code}\n" -s') do
  its(:stdout) { should match /^200$/ }
end

#####指定したポート80番がListenになっているか確認#####
describe port(80) do
  it { should be_listening }
end

#####指定したファイルがあるか確認#####
describe file('/etc/nginx/conf.d/rails_study.conf') do
 it { should exist }
end