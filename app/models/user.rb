class User < ApplicationRecord
    before_save { self.email = email.downcase }
    # Means that if the user is destroyed, all connected data associated with him will be destroyed also.
    has_many :articles, dependent: :destroy
    validates :username, presence: true,  uniqueness: { case_sensitive: false }, length: { minimum: 3, maximum: 25 }
    VALID_EMAIL_REGEX= /^(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})$/i
    validates :email, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 105 }, format: { with: VALID_EMAIL_REGEX, multiline: true, message: "You should provide the correct email!" }
    has_secure_password
end