# frozen_string_literal: true

# rubocop:disable RSpec/AnyInstance
def authorize_request
  Api::BaseController.any_instance.stub(:authorize).and_return(true)
end
# rubocop:enable RSpec/AnyInstance
