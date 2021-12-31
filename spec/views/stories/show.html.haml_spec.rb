require 'rails_helper'

RSpec.describe "stories/show", type: :view do
  before(:each) do
    @story = assign(:story, Story.create!(
      title: "Title",
      body: "MyText",
      pond_key: "Pond Key",
      ripple_uuid: "Ripple Uuid"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Pond Key/)
    expect(rendered).to match(/Ripple Uuid/)
  end
end
