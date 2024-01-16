class Task < ApplicationRecord
  validates :name, presence: true, length: { maximum: 30 }
  # カスタムしたバリデーションの場合はvalidateメソッドを用いる
  validate  :validate_name_not_incloding_comma

  private
  def validate_name_not_incloding_comma
    # nameがnilでもエラーにならない
    errors.add(:name, 'にカンマを含めることはできません。') if name&.include?(',')
  end
end

