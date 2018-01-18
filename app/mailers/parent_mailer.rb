class ParentMailer < ApplicationMailer
  default from: 'notifications@webtutorialnashville.com'

  def shadow_schedule_email(parent, student)
    @parent = parent
    @student_count = @parent.students.count
    @students = @parent.students
    @shadow_spots = @students.first.shadow_spots
    @shadow_date = @shadow_spots.first.date
    @shadow_date_for_print = @shadow_date.strftime("%B %-d")
    teacher_emails = @students.map { |s| s.shadow_spots.map { |ss| ss.teacher.email } }.flatten
    @meeting_time = if student.shadow_spots.count == 1
      student.shadow_spots.first.time
    else
      times = student.shadow_spots.map { |ss| ss.time }
      times.first < times.second ? times.first : times.second
    end

    mail(
      to: @parent.email,
      cc: teacher_emails,
      subject: 'Your WEB Shadow Schedule')
  end
end