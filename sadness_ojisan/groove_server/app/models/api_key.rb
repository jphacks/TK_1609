class ApiKey < ActiveRecord::Base
  before_create :generate_access_token, :set_expiration, :set_active
  belongs_to :dancer

  def before_expired?
    logger.debug("[API_KEY_MODEL] before_expired?アクション")
    logger.debug("[API_KEY_MODEL] self.expires_at:" + self.expires_at.to_s)
    if self.expires_at == nil then
      DateTime.now < '3000-12-30' # apiキーの有効期限がない時は, 常にfalseになるようにする.
    else
      DateTime.now < self.expires_at
    end
  end

  def set_active
    logger.debug("[API_KEY_MODEL] set_activeアクション")
    self.active = true
  end

  def set_expiration
    logger.debug("[API_KEY_MODEL] set_expirationアクション")
    self.expires_at = DateTime.now + 1
  end

  private
    def generate_access_token
      logger.debug("[API_KEY_MODEL] generate_access_tokenアクション")
      begin
        self.access_token = SecureRandom.hex
      end while self.class.exists?(access_token: access_token)
    end
end
