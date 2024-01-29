class Task < ApplicationRecord
  validates :name, presence: true, length: { maximum: 30 }
  # カスタムしたバリデーションの場合はvalidateメソッドを用いる
  validate  :validate_name_not_incloding_comma

  belongs_to :user

  # DBへのクエリ用メソッドのショートカットを作成することができる
  # current_user.tasks.recent で現在のユーザのタスクを降順で取得 
  scope :recent, -> { order(created_at: :desc)}

  def self.ransackable_attributes(auth_object = nil)
    ["name"] 
  end
  
  def self.ransackable_associations(auth_object = nil)
    ["user"]
  end
  private
  
  def validate_name_not_inclraoding_comma
    # nameがnilでもエラーにならない
    errors.add(:name, 'にカンマを含めることはできません。') if name&.include?(',')
  end

end

