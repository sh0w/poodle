require 'test_helper'

class CourseTest < ActiveSupport::TestCase
  test "should not save without title or description" do
    c = Course.new
    assert !c.save, "Saved the post without a title"
  end
end
