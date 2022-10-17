require_relative './base_controller.rb'
# require 'ostruct'

class ProductsController < BaseController
  # GET /products
  #
  def index
    @title = "So many products"
    # @products = (1..5).map do |i|
    #   OpenStruct.new(id: i, name: "Product #{i}")
    # end
    @products = Product.all
    build_response render_template
  end

  # GET /products/:id?name=Optional%20Custom%20Name
  #
  def show
    @product = Product.find(params[:id])
    # product_name = params["name"] || "Product #{params[:id]}"
    @title = "#{@product.name}'s page"
    # @product = OpenStruct.new(id: params[:id], name: product_name)
    build_response render_template
  end

  # GET /products/new
  #
  def new
    @title = "More products please"
    build_response render_template
  end

  # POST /products
  #
  def create
    # redirect_to "products/"
    product = Product.new(name: params['product']['name'])
    product.save
    redirect_to "products/#{product.id}"
  end
end

# require_relative './base_controller.rb'
#
# class ProductsController < BaseController
#
#   # GET /products
#   #
#   def index
#     build_response product_page("display the list of all products here")
#   end
#
#   # GET /products/:id
#   #
#   def show
#     build_response product_page("display the single product asked by ##{params[:id]}")
#   end
#
#   # GET /products/new
#   #
#   def new
#     build_response product_page("build and create a new product from params")
#   end
#
#   # POST /products
#   # not implemented for now
#   #
#   def create
#     redirect_to "/products"
#   end
#
#   private
#
#   def product_page(message)
#     <<~HTML
#       <html>
#         <head><title>Products on Rack - Products</title></head>
#         <body>
#           <h1>This is ProductsController##{params[:action]}</h1>
#           <p>#{message}</p>
#         </body>
#       </html>
#     HTML
#   end
# end
