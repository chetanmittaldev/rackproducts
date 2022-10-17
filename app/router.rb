# GET    /resource           # index  - get a list of the resources
# GET    /resource/:id       # show   - get a specific resource
# GET    /resource/new       # new    - get an HTML page with a form
# POST   /resource           # create - create a new resource

class Router
  def initialize(request)
    @request = request
  end

  def controller_name
    "#{route_info[:resource].capitalize}Controller"
  end

  def controller_class
    Object.const_get(controller_name)
  rescue NameError
    nil
  end

  def route!
    # if @request.path == "/"
    #   [200, { "Content-Type" => "text/plain" }, ["This is the products-on-rack router"]]
    # elsif @request.path == "/welcome"
    #   [200, { "Content-Type" => "text/plain" }, ["This is the welcome route"]]
    # else
    #   not_found
    # end
    if klass = controller_class
      add_route_info_to_request_params!
      controller = klass.new(@request)
      action = route_info[:action]
      if controller.respond_to?(action)
        puts "\nRouting to #{klass}##{action}"
        return controller.public_send(action)
      end
    end
    not_found
  end

  private

  def add_route_info_to_request_params!
    @request.params.merge!(route_info)
  end

  def not_found(msg = "Not Found")
    [404, { "Content-Type" => "text/plain" }, [msg]]
  end

  # find the request route else route to 'base controller' 
  def route_info
    @route_info ||= begin
      resource = path_fragments[0] || "base" # route to base_controller if naked path
      id, action = find_id_and_action(path_fragments[1]) # generate route path
      { resource: resource, action: action, id: id } # return the route hash
    end
  end

  # find the :id params and action
  def find_id_and_action(fragment)
    case fragment
    when "new"
      [nil, :new]
    when nil
      action = @request.get? ? :index : :create
      [nil, action]
    else
      [fragment, :show]
    end
  end

  # generate route path
  def path_fragments
    @fragments ||= @request.path.split("/").reject { |s| s.empty? }
  end
end
