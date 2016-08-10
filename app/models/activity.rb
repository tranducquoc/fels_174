class Activity < ActiveRecord::Base
  belongs_to :user
  validates :user, presence: true
  enum action_type: [:learned, :following, :followed]
  scope :reverse, -> {order(created_at: :desc)}

  def show_activity
    puts "action_type = #{action_type}"
    user = User.find_by id: user_id
    if action_type == "learned"
      lesson = user.lessons.find_by id: target_id
      totalWord = lesson.results.count
      return "#{action_type} #{totalWord} word in Lesson #{lesson.category.name} - (#{created_at})"
    elsif action_type == "following"
      user_followed = User.find_by id: target_id
      return "You are #{action_type} #{user_followed.name} - (#{created_at})"
    else
      user_follower = User.find_by id: target_id
      return "You was #{action_type} by #{user_follower.name} - (#{created_at})"
    end
  end
end
