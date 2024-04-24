class ErrorSerializer

  def initialize(error_object)
    @error_object = error_object
  end

  def no_method_error
    {
      errors: [
        {
          status: 400,
          detail: "Invalid parameters, try again."
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
