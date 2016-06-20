class ApplicationController < ActionController::API
	# include ::ActionController::Serialization
	# include ActiveModel::Serialization

	def default_serializer_options
    {module_namespace: self.class.name.deconstantize}
  end

end