class TopsController < ApplicationController
    def index
    	@tops=Top.all
    end

    def show
			@top=Top.find(params[:id])
    end

    def new
			@top=Top.new
    end

    def create
			@top=Top.new(top_params)

			if @top.save
				flash[:success] = '正常に投稿されました'
        
				redirect_to @top
			else
				flash.now[:danger] = '投稿されませんでした'
				render :new_top_path
			end
    end

    def edit
			@top=Top.find(params[:id])
    end

    def update
			@top = Top.find(params[:id])

      if @top.update(top_params)
        flash[:success] = '正常に更新されました'
        redirect_to @top
      else
        flash.now[:danger] = '更新されませんでした'
        render :edit
      end
    end

    def destroy
      @top=Top.find(params[:id])
      @top.destroy

      flash[:success] = '正常に削除されました'
      redirect_to tops_url
    end
end

private

  # Strong Parameter
  def top_params
    params.require(:top).permit(:content,:name)
  end

