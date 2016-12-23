require 'dashing'

configure do
  set :auth_token, '6e96691d458e00628e109f2f83c734c8b1a6009c'
  set :default_dashboard, 'main'

  helpers do
    def protected!
      # Put any authentication code you want in here.
      # This method is run before accessing any resource.
    end
  end
end

map Sinatra::Application.assets_prefix do
  run Sinatra::Application.sprockets
end

run Sinatra::Application
