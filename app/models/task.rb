class Task < ApplicationRecord
  #imageを紐づける
  has_one_attached :image
  validates :name, presence: true, length: { maximum: 30 }
  # カスタムしたバリデーションの場合はvalidateメソッドを用いる
  validate  :validate_name_not_including_comma

  belongs_to :user

  # DBへのクエリ用メソッドのショートカットを作成することができる
  # current_user.tasks.recent で現在のユーザのタスクを降順で取得 
  scope :recent, -> { order(created_at: :desc)}

  def self.ransackable_attributes(auth_object = nil)
    ["name", "created_at"] 
  end
  
  def self.ransackable_associations(auth_object = nil)
    ["user"]
  end

  # どの属性をどの順番で出力するのかを定義
  def self.csv_attributes
    # %w[ name, description, created_at, updated_at ]
    ["name", "description", "created_at", "updated_at"]
  end

  def self.generate_csv
    CSV.generate(headers: true) do |csv|
      #一行目としてヘッダーを出力
      csv << csv_attributes
      #allメソッドで全タスクを取得し、１レコードずつCSVとして出力
      all.each do |task|
        csv << csv_attributes.map{|attr| task.send(attr) }
      end
    end
  end
  
  def self.import(file)
    # foreachメソッドで一行ずつ読み込み
    CSV.foreach(file.path, headers: true) do |row|
      # classに対してimportが直接呼ばれる場合はTask.newと同義になる
      task = new
      # to_hashメソッドより、csvの各カラムをハッシュ形式に変換、CSVのヘッダー情報をからデータベースに登録するため
      # 意図しないデータの登録を避けるためsliceに配列を渡して登録予定のカラムの情報のみを登録できるようにフィルタリングする
      task.attributes = row.to_hash.slice(*csv_attributes)
      # データベースに登録
      task.save!
    end
  end

  private
  
  def validate_name_not_including_comma
    # nameがnilでもエラーにならない
    errors.add(:name, 'にカンマを含めることはできません。') if name&.include?(',')
  end

end

