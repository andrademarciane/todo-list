require 'rails_helper'

describe Task do
  describe 'validations' do
    it { is_expected.to validate_presence_of :name}
  end

  describe 'association' do
    it { is_expected.to belong_to :board }
    it { is_expected.to have_many(:steps).dependent(:destroy) }
  end
end