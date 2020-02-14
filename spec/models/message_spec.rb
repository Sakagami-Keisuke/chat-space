require 'rails_helper'

RSpec.describe Message, type: :model do
  # メッセージがあれば保存できる
  # build(:message)でMessageモデルのインスタンスを生成
  # buildメソッドは、カラム名: 値の形で引数を渡すことによってファクトリーで定義されたデフォルトの値を上書きする
  # メッセージがあれば保存できることを確かめたいのでimage: nilを引数として、画像を持っていないインスタンスを生成
  describe '#create' do
    context 'can save' do
      it 'is valid with content' do
        expect(build(:message, image: nil)).to be_valid
      end

      # 画像があれば保存できる
      # content: nilをbuildメソッドの引数とすることによってメッセージを持っていないインスタンスを生成
      it 'is valid with image' do
        expect(build(:message, content: nil)).to be_valid
      end

      # メッセージと画像があれば保存できる
      # ファクトリーでデフォルトの値が定義されているのでbuild(:message)と記述するだけで、メッセージと画像を持ったインスタンスを生成
      it 'is valid with content and image' do
        expect(build(:message)).to be_valid
      end
    end


    context 'can not save' do

      # メッセージも画像も無いと保存できない
      # buildメソッドの引数でメッセージも画像もnilにすることによって、必要なインスタンスを生成
      # 作成したインスタンスがバリデーションによって保存ができない状態かチェックするため、valid?メソッドを利用
      # valid?メソッドを利用したインスタンスに対して、errorsメソッドを使用することによって、バリデーションにより保存ができない状態である場合なぜできないのかを確認
      # contentもimageもnilの今回の場合、'を入力してください'というエラーメッセージが含まれることが分かっているため、includeマッチャを用いて以下のようにテストを記述
      # expectの引数に関して、message.errors[:カラム名]と記述することによって、そのカラムが原因のエラー文が入った配列を取り出すことができます。こちらに対して、includeマッチャを利用してエクスペクテーションを作っています。
      it 'is invalid without content and image' do
        message = build(:message, content: nil, image: nil)
        message.valid?
        expect(message.errors[:content]).to include("を入力してください")
      end

      # group_idが無いと保存できない
      it 'is invalid without group_id' do
        message = build(:message, group_id: nil)
        message.valid?
        expect(message.errors[:group]).to include("を入力してください")
      end

      # user_idが無いと保存できない
      it 'is invaid without user_id' do
        message = build(:message, user_id: nil)
        message.valid?
        expect(message.errors[:user]).to include("を入力してください")
      end
    end
  end
end
# group_idが無いと保存できない場合、user_idが無いと保存できない場合に関してですが、これらもメッセージも画像もないと保存できない場合と同じ方法でテストを書く