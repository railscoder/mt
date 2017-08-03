# encoding: UTF-8

class CompanyMailer < ApplicationMailer
  default from: "no-reply@konyhov.com"


  def welcome_letter(email)
    mail(to: email, subject: "На связи Конюхов!")
  end

  def email_marketing(email)
    mail(to: email, subject: "Дарим 500 клиентов!")
  end
end
