# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: ENV[`SENDE_EMAIL`]
  layout 'mailer'
end
