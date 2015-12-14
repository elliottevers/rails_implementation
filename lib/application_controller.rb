require 'active_support'
require 'active_support/core_ext'
require 'erb'


class ApplicationController
  attr_reader :req, :res, :params

  def initialize(req, res, params = {})
    @req = req
    @res = res
    @params = params.merge(req.params)
  end

  def render(material)
    if !(material.class == Symbol)
      hopefully_json = material
      @res.write(hopefully_json)
      @res['Content-Type'] = "application/json"
    else
      template_name = material
      template_file = File.join(
        File.dirname(__FILE__),
        "..",
        "views",
        self.class.name.underscore.split("_").first.singularize,
        "#{template_name}.html.erb"
      )
      @res.write(ERB.new(File.read(template_file)).result(binding))
      @res['Content-Type'] = "text/html"
    end
  end

  def redirect_to(url)
    @res.status = 302
    @res["Location"] = url
  end

  def run_method(name)
    self.send(name)
  end

end
