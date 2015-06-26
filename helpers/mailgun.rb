module Sinatra
  module SimpleRubyBlog
    module Helpers
      module Mail 
	    def self.send_all from, subject, body, tpl
			Person.all(:email.not => nil).each do |person|
				send(from, person.email, subject, body, tpl)
			end
	    end
        def self.send from, to, subject, body, tpl
		  if !$maingun_apikey.nil?
			template = ERB.new File.new(tpl).read, nil, "%"
			html = template.result(binding)

			message_params = {:from    => from,
							  :to      => to,
							  :subject => subject,
							  :html    => html}

			conn = Faraday.new('https://api.mailgun.net/v3', { ssl: { verify: false } }) do |faraday|
			  faraday.request  :url_encoded
			  faraday.response :logger
			  faraday.adapter  Faraday.default_adapter
			end
			 
			conn.basic_auth('api', $maingun_apikey)
			conn.post("#{$maingun_domain}/messages", message_params)
		  end
        end
      end
    end
  end
end