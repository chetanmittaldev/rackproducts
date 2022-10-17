# Import all files in app folder and require each file
app_files = File.expand_path('../app/**/*.rb', __FILE__)
Dir.glob(app_files).each { |file| require(file) }

class Application
  def call env
    request = Rack::Request.new env
    serve_request(request)
    # headers = {'Content-Type' => 'text/html'}
    # response = ["This is the products app built on using only Rack and its middlewares, and YAML store"] 
    # ['200', headers, response]
  end
  
  def serve_request(request)
    Router.new(request).route!
  end
end
