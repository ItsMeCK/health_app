class ApplicationController < ActionController::API

	def default_serializer_options
    {module_namespace: self.class.name.deconstantize}
  end

end