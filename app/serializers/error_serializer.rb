class ErrorSerializer
  def initialize(error_object)
    @error_object = error_object
  end

  def no_method_error
    {
      errors: [
        {
          detail: "No location provided"
        }
      ]
    }
  end
end
