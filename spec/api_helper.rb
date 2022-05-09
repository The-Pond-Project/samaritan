# frozen_string_literal: true

def authorize_request
  Api::BaseController.any_instance.stub(:authorize).and_return(true)
end
