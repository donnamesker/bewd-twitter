class Session < ApplicationRecord    
    belongs_to :user
    
    before_validation :generate_session_token

    validates :token, presence: true, uniqueness: true
    validates :user_id, presence: true
    
    private
    def generate_session_token
        self.token = SecureRandom.urlsafe_base64
    end
end
