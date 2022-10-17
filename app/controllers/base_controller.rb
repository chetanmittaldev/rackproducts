# This class is extended by all the controllers
# 3 methods = 1) build response 2) redirect 3) return params
#

require 'erb'

class BaseController
  attr_reader :request

  def initialize(request)
    @request = request
  end

  def index
    # build_response <<~HTML
    #   <html>
    #     <head><title>Products are on Rack</title></head>
    #     <body>
    #       <h1>This is the basecontroller#index</h1>
    #       <p>Welcome to the base controller!</p>
    #     </body>
    #   </html>
    # HTML
    build_response render_template
  end

  private

  def build_response(body, status: 200)
    [status, { "Content-Type" => "text/html" }, [body]]
  end

  def redirect_to(uri)
    [302, { "Location" => uri }, []]
  end

  def params
    request.params
  end

  def render_template(name = params[:action])
    templates_dir = self.class.name.downcase.sub("controller", "")
    template_file = File.join(templates_dir, "#{name}.html.erb")

    file_path = template_file_path_for(template_file)

    if File.exists?(file_path)
      puts "Rendering template file #{template_file}"
      render_erb_file(file_path)
    else
      "ERROR: no available template file #{template_file}"
    end
  end

  def template_file_path_for(file_name)
    File.expand_path(File.join("../../views", file_name), __FILE__)
  end

  def render_erb_file(file_path)
    raw = File.read(file_path)
    ERB.new(raw).result(binding)
  end

  def render_partial(template_file)
    file_path = template_file_path_for(template_file)

    if File.exists?(file_path)
      puts " > Rendering partial file #{template_file}"
      render_erb_file(file_path)
    else
      "ERROR: no available partial file #{template_file}"
    end
  end
end
