class Micropost < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: Settings.content_length}
  validate :picture_size

  scope :order_created, ->{order created_at: :desc }

  mount_uploader :picture, PictureUploader

  private

  def picture_size
    return unless picture.size > Settings.max_upload_size.megabytes
    errors.add :picture, I18n.t("less_than_5mb")
  end
end
