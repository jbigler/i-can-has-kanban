# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: "jbigler+sendgrid@saturnstudio.com"
  layout "mailer"
end
