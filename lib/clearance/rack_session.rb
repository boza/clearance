module Clearance
  class RackSession
    def initialize(app)
      @app = app
    end

    def call(env)
      session = Clearance::Session.new(env)
      env[:clearance] = session
      response = @app.call(env)
      domain = Rack::Request.new(env).host()
      session.add_cookie_to_headers response[1], domain
      response
    end
  end
end
