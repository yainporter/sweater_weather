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

  def error
    {
      errors: [
        {
          status: @error_object.status_code,
          detail: @error_object.message
        }
      ]
    }
  end
end
