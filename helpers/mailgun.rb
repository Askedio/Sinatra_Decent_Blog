module Sinatra
  module SimpleRubyBlog
    module Helpers
      module Mail 
        def self.send from, to, subject, body, tpl
            template = ERB.new File.new(tpl).read, nil, "%"
            html = template.result(binding)

            message_params = {:from    => from,
                              :to      => to,
                              :subject => subject,
                              :html    => html}

			conn = Faraday.new('https://api.mailgun.net/v2', { ssl: { verify: false } }) do |faraday|
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