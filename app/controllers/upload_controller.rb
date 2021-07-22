require 'net/http'
class UploadController < ApplicationController
  layout 'customised_layout'
  def upload
    if params[:file].present?
      data=File.read(params[:file].path)
      uri = URI.parse('https://validator.w3.org/nu/?out=json')
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      request = Net::HTTP::Post.new(uri.path, {'Content-Type' => 'text/html'})
      request.body = data
      response = http.request(request)
      errors = nil ||  response.body.partition("<strong>Error").last
      redirect_to root_path(errors:errors) if errors.present?
    end
  end

  def dashboard

  end

end
