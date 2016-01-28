require 'active_support'
require 'active_support/core_ext'
require_relative 'route'

class Router
  attr_reader :routes

  def initialize
    @routes = []
  end

  [:get, :post, :put, :delete].each do |http_method|
    define_method(http_method) do |pattern, full_method|
      controller, method = full_method[:to].split("#")
      add_route(pattern, http_method, controller, method)
    end
  end

  def add_route(pattern, verb, controller, method)
    @routes << Route.new(pattern, verb, controller, method)
  end

  def run(req, res)
    if find_match(req).nil?
      res.status = 404
    else
      find_match(req).run(req, res)
    end
  end

  def find_match(req)
    @routes.find { |route| route.matches?(req) }
  end

  def draw(&proc)
    instance_eval(&proc)
  end

end
