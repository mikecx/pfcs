# Preview all emails at http://localhost:3000/rails/mailers/patients_mailer
class PatientsMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/patients_mailer/after_care
  def after_care
    PatientsMailer.after_care
  end
end
