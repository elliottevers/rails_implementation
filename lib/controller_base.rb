require 'active_support'
require 'active_support/core_ext'
require 'erb'


class ControllerBase
  attr_reader :req, :res, :params

  def initialize(req, res, route_params = {})
    @req, @res = req, res
    @params = route_params.merge(req.params)
  end

  def render(template_name)
    dir_path = File.dirname(__FILE__)
    template_fname = File.join(
      dir_path, "..",
      "views", self.class.name.underscore.split("_").first.singularize, "#{template_name}.html.erb"
    )

    template_code = File.read(template_fname)

    render_content(
      ERB.new(template_code).result(binding),
      "text/html"
    )
  end

  def render_content(content, content_type)
    @res.write(content)
    @res['Content-Type'] = content_type
    nil
  end

  def redirect_to(url)
    @res.status = 302
    @res["Location"] = url
    nil
  end

  def run_method(name)
    self.send(name)
    nil
  end

end
