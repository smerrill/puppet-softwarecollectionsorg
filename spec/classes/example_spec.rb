require 'spec_helper'

describe 'softwarecollectionsorg' do
  context 'supported operating systems' do
    ['Debian', 'RedHat'].each do |osfamily|
      describe "softwarecollectionsorg class without any parameters on #{osfamily}" do
        let(:params) {{ }}
        let(:facts) {{
          :osfamily => osfamily,
        }}

        it { should compile.with_all_deps }

        it { should contain_class('softwarecollectionsorg::params') }
        it { should contain_class('softwarecollectionsorg::install').that_comes_before('softwarecollectionsorg::config') }
        it { should contain_class('softwarecollectionsorg::config') }
        it { should contain_class('softwarecollectionsorg::service').that_subscribes_to('softwarecollectionsorg::config') }

        it { should contain_service('softwarecollectionsorg') }
        it { should contain_package('softwarecollectionsorg').with_ensure('present') }
      end
    end
  end

  context 'unsupported operating system' do
    describe 'softwarecollectionsorg class without any parameters on Solaris/Nexenta' do
      let(:facts) {{
        :osfamily        => 'Solaris',
        :operatingsystem => 'Nexenta',
      }}

      it { expect { should contain_package('softwarecollectionsorg') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
