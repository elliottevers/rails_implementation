require 'active_support'
require 'active_support/core_ext'

class Route
  attr_reader :pattern, :verb, :controller, :method

  def initialize(pattern, verb, controller, method)
    @pattern = Regexp.new(pattern)
    @verb = verb
    @controller = (controller
                          .to_s
                          .capitalize
                          .pluralize + "Controller"
                        ).constantize
    @method = method
  end

  def matches?(req)
    (verb == req.request_method.downcase.to_sym) && !!(@pattern =~ req.path)
  end

  def run(req, res)
    match_data = @pattern.match(req.path)
    route_params = Hash[match_data.names.zip(match_data.captures)]
    @controller.new(req, res, route_params).run_method(method)
  end
end

class Router
  attr_reader :routes

  def initialize
    @routes = []
  end

  def add_route(pattern, verb, controller, method)
    @routes << Route.new(pattern, verb, controller, method)
  end

  def find_match(req)
    routes.find { |route| route.matches?(req) }
  end

  def draw(&proc)
    instance_eval(&proc)
  end

  [:get, :post, :put, :delete].each do |http_method|
    define_method(http_method) do |pattern, controller, method|
      add_route(pattern, http_method, controller, method)
    end
  end

  def run(req, res)
    matching_route = find_match(req)

    if matching_route.nil?
      res.status = 404
    else
      matching_route.run(req, res)
    end
  end
end
