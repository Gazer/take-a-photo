module ActionController
  # CgiRequest and TestRequest provide concrete implementations.
  class AbstractRequest
    alias_method :original_parameters, :parameters

    def parameters
      original_parameters
    
      if @parameters && @parameters.keys.include?("px0")
        @parameters[:take_a_photo] = TakeAPhoto.new @parameters
      end
      @parameters
    end
  end
end