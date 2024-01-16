class ChangeTasksNameLimit30 < ActiveRecord::Migration[7.1]
  # upとdownに分ける理由は、このバージョンの変更を取り消す際に,
  # changeメソッドで記載し、upの状況のみを記載してある状態だと、取り消した際に例外が発生して元に戻せないため
  # upの状況からdownの状況のコードを生成できないため(明示的にどのように戻すか指定する必要がある)
  def up
    change_column :tasks, :name, :string, limit: 30
  end

  def down
    change_column :tasks, :name, :string
  end
end
