require 'rails_helper'

describe Step do
  describe 'validations' do
    it { is_expected.to validate_presence_of :name}
  end

  describe 'association' do
    it { is_expected.to belong_to :task }
  end
end