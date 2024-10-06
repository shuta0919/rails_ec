# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: "postmaster@#{ENV['MAILGUN_DOMAIN']}"
  layout 'mailer'
end
