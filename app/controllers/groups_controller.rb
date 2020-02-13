class GroupsController < ApplicationController
  # before_action :set_group, only: :update

  def index
  end

  def new
    @group = Group.new
    @group.users << current_user
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      redirect_to root_path, notice: 'グループを作成しました'
    else
      render :new
    end
  end

  def edit
    @group = Group.find(params[:id])
    
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to group_messages_path(@group) , notice: 'グループを更新しました'
    else
      render :edit
    end
  end
# redairect_toのパスばPrefix名+このコントローラで作成するインスタンス変数@group(idにあるカラムデータを格納したもの)

  private
  def group_params
    params.require(:group).permit(:name, user_ids: [])
  end

  # def set_group
  #   @group = Group.find(params[:group_id])
  # end

# リファクタリングできること
# いくつも同じ@group定義があるので
# set_groupメソッドをbefore_action onlyで機能させれば、
# 各アクションの@group = Group.find(params[:id])を消せる

end
