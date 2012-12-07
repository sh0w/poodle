module ApplicationHelper
  def convert_to_message (a)

    @c = Course.find(a.course_id)

    case a.text
      when "create_course"
        @message = [
            User.find(a.creator_id).username,
            "created the course",
            @c.title
        ]*" "
      when "start_course"
        @message = [
            User.find(a.creator_id).username,
            "started taking ",
            @c.title
        ]*" "
      when "comment_course"
        @message = [
            User.find(a.creator_id).username,
            "commented on",
            @c.title
        ]*" "

    end

    @message.blank? ? @c.text : @message
  end
end
