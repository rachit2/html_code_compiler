require 'net/http'
class UploadController < ApplicationController

  def upload
    file_path = params[:file].path if params[:file].present?
    if file_path.present?
      data=File.read(file_path)
      uri = URI.parse('https://validator.w3.org/nu/?out=json')
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      request = Net::HTTP::Post.new(uri.path, {'Content-Type' => 'text/html'})
      request.body = data
      response = http.request(request)
      @errors =  response.body.partition("Error").last.force_encoding('utf-8')
      @errors = @errors.present? ? "<strong>Error:</strong>" + @errors : "Success, No Error"
      render json:{error:@errors}
    end
  end

  def dashboard

  end

end
