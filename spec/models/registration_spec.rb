require 'rails_helper'

RSpec.describe Registration, type: :model do
  describe 'associations' do
    it { should belong_to(:course) }
    it { should belong_to(:student) }
  end

  describe 'validations' do
    it { should validate_presence_of(:course)}
    it { should validate_presence_of(:student)}
    it { should validate_uniqueness_of(:course_id).scoped_to(:student_id)}
  end
end
