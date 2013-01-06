module ApplicationHelper
  def convert_to_message (a)

    if(!a.course_id.blank?)
      @c = Course.find(a.course_id)
    end


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
      when "signup"
        @message = [
            User.find(a.user_id).username,
            "has signed up."
        ]*" "

    end

    @message.blank? ? @c.text : @message
  end
end
