# frozen_string_literal: true

module ApplicationHelper
  include LocalTimeHelper
  include Pagy::Frontend

  # rubocop:disable Rails/OutputSafety
  def show_svg(path)
    return unless path.include?('.svg')

    File.open("app/assets/images/#{path}", 'rb') do |file|
      raw file.read
    end
  end
  # rubocop:enable Rails/OutputSafety
end
