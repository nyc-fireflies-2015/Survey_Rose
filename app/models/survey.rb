class Survey < ActiveRecord::Base
	belongs_to :creator, class_name: 'User'
	has_many :questions
	has_many :votes

	def already_voted?(user)
		votes.map(&:voter).any? {|voter| voter == user}
	end

  def update_votes(params={})
    self.questions.each do |question|
      voter_choice_id = params["#{question.id}"]
      new_vote = question.votes.new
      new_vote.option = Option.find_by(id: voter_choice_id)
      new_vote.survey_id = self.id
      new_vote.save
    end
  end
end
