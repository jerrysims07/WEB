class Student < ActiveRecord::Base
  belongs_to :parent
  has_many :student_shadows
  has_many :shadow_spots, through: :student_shadows
  has_many :registrations, dependent: :destroy
  has_many :courses, through: :registrations
  has_many :wait_listed_students, dependent: :destroy

  accepts_nested_attributes_for :student_shadows

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :date_of_birth, presence: true
  validates :grade, presence: true
  validates :emergency_contact, presence: true
  validates :emergency_phone, presence: true
  validates :parent, presence: true

  attr_accessor :shadow_spot

  DAYS_ORDER = %w(Monday Tuesday Wednesday Thursday Friday)

  def course_count
    courses.where.not(name: "Study Hall").count
  end

  def daily_schedule(weekday)
    courses.where(day: weekday).sort_by { |c| c.start_time }
  end

  def full_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end

  def parents_full_name
    "#{parent.first_name.capitalize} #{parent.last_name.capitalize}"
  end

  def should_be_offered_lunch?
    !shadow_spots.select { |ss| ss.time == "10:15 AM" }.empty?
  end

  def study_hall_count
    courses.where(name: "Study Hall").count
  end

  def to_s
    "#{first_name} #{last_name}"
  end

  def wait_listed_courses
    wait_listed_students.map { |wls| wls.course }
  end

end
