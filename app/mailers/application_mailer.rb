class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch("MAILER_FROM", "no-reply@clubdeportivo.com")
  layout "mailer"
end
