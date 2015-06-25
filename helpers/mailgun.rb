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

            
            mg_client = Mailgun::Client.new $maingun_apikey
            mg_client.send_message $maingun_domain, message_params
        end
      end
    end
  end
end