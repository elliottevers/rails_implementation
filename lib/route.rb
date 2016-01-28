require 'active_support'
require 'active_support/core_ext'

class Route
  attr_reader :pattern, :verb, :associated_controller, :method

  def initialize(pattern, verb, associated_controller, method)
    @pattern = Regexp.new(pattern)
    @verb = verb
    @associated_controller = (associated_controller
                    .to_s
                    .capitalize
                    .pluralize + "Controller"
                  ).constantize
    @method = method
  end

  def run(req, res)
    match_data = @pattern.match(req.path)
    params = Hash[match_data.names.zip(match_data.captures)]
    @associated_controller.new(req, res, params).send(method)
  end

  def matches?(req)
    (@verb == req.request_method.downcase.to_sym) && !!(@pattern =~ req.path)
  end

end
