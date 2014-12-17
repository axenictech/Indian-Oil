require 'mail'
class Inform
	def sendTo(subject,message)

	begin
		username=""
		password=""
		mail_to=""
		mail_from=""

		options = { 
			:address              => "smtp.gmail.com",
            :port                 => 587,
            :domain               => 'smtp.gmail.com',
            :user_name            => username,
            :password             => password,
            :authentication       => 'plain',
            :enable_starttls_auto => true  }
		Mail.defaults do
			  delivery_method :smtp, options
		end
		Mail.deliver do
		      to      mail_to
		      from    mail_from
			  subject subject
		      body    message
		end
	rescue Exception=>e
		p e
	end
	end
end