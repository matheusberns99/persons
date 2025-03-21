class ApplicationController < ActionController::API
  def render_json(content, serializer, return_name, status = 200)
    options = {
      adapter: :json,
      root: return_name
    }

    if content.respond_to?(:to_ary)
      options[:each_serializer] = serializer
    else
      options[:serializer] = serializer
    end

    returned_json = ActiveModelSerializers::SerializableResource.new(content, options).as_json

    render json: returned_json, status: status
  end
end
