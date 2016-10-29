class Dancer < ActiveRecord::Base
  authenticates_with_sorcery!
  validates :password, confirmation: true
  has_many :favorites
  has_many :records
  has_many :questions
  has_many :answers
  has_many :comments
  has_many :follows
  has_many :api_keys

  def self.login?(access_token)
    logger.debug("[DANCER_MODEL] self.login?アクション")
    api_key = ApiKey.find_by_access_token(access_token)
    return false if !api_key || !api_key.before_expired? || !api_key.active
    return !self.find(api_key.dancer_id).nil?
  end

  def activate
    logger.debug("[DANCER_MODEL] activateアクション")
    if !api_key
      return ApiKey.create(dancer_id: self.id)
    else
      if !api_key.active
        api_key.set_active
        api_key.save
      end
      if !api_key.before_expired?
        api_key.set_expiration
        api_key.save
      end
      logger.debug("[DANCER_MODEL] api_key:" + api_key.to_s)
      return api_key
    end
  end

  def inactivate
    logger.debug("[DANCER_MODEL] inactivateアクション")
    api_key.active = false
    api_key.save
  end

  private
    def api_key
      logger.debug("[DANCER_MODEL] api_keyアクション")
      @api_key ||= ApiKey.find_by_dancer_id(self.id)
    end
end
