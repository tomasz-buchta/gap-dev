module CommonResponseHandler
  def match_result_to_response(result, matcher)
    matcher.call(result) do |m|
      m.success do |target_groups|
        yield target_groups
      end
      m.failure :not_found do |message|
        render status: :not_found, json: { message: "Not found", errors: message }
      end
      m.failure :validation_failed do |errors|
        render status: :bad_request, json: { message: "Invalid params", errors: errors }
      end
      m.failure do |message|
        render status: :internal_server_error, json: { message: "Something went wrong", errors: message }
      end
    end
  end
end
