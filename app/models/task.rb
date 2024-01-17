class Task < ApplicationRecord
  validates :name, presence: true, length: { maximum: 30 }
  # カスタムしたバリデーションの場合はvalidateメソッドを用いる
  validate  :validate_name_not_incloding_comma

  belongs_to :user

  # DBへのクエリ用メソッドのショートカットを作成することができる
  # current_user.tasks.recent で現在のユーザのタスクを降順で取得 
  scope :recent, -> { order(created_at: :desc)}
  private
  def validate_name_not_incloding_comma
    # nameがnilでもエラーにならない
    errors.add(:name, 'にカンマを含めることはできません。') if name&.include?(',')
  end

end

