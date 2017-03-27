# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

APP_CONFIG = YAML.load_file("#{Rails.root}/config/config.yml")

ActionMailer::Base.smtp_settings = {
	:address		=> 'smtp.sendgrid.net',
	:port			=> '587',
	:authentication => :plain,
	:user_name		=> ENV['SENDGRID_USERNAME'],
	:password		=> ENV['SENDGRID_PASSWORD'],
	:domain			=> 'heroku.com',
	:enable_starttls_auto => true
}