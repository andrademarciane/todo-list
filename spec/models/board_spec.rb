require 'rails_helper'

describe Board do
  describe 'validations' do
    it { is_expected.to validate_presence_of :name}
  end

  describe 'association' do
    it { is_expected.to have_many(:tasks).dependent(:destroy) }
    it { accept_nested_attributes_for(:tasks) }
  end
end