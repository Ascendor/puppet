require 'spec_helper'
describe 'webnode' do

  context 'with defaults for all parameters' do
    it { should contain_class('webnode') }
  end
end
