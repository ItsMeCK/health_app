class Calculator

def self.limit_and_offset(params)
	limit = (params[:limit] || 50000).to_i
	offset = (params[:offset] || 1).to_i
	offset = (offset == 1 ? offset : ((offset - 1) * limit) + 1) if params[:offset]
  offset = offset || 1
  return limit, offset
end	

end