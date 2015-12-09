require 'rack'
require_relative 'lib/db_connection'
require_relative 'config/routes'
controller_files = File.join(File.dirname(__FILE__), "/controllers/*.rb")
Dir[controller_files].each {|file| require file }

@execute.call

DBConnection.reset

app = Proc.new do |env|
  req = Rack::Request.new(env)
  res = Rack::Response.new
  @router.run(req, res)
  res.finish
end

Rack::Server.start(
 app: app,
 Port: 3000
)
