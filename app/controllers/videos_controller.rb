class VideosController < ApplicationController
  before_action :authenticate_blogger!, except: [:index, :show, :search]
  layout "bloggers", except:[:index, :show, :search]
 before_action :set_about, only: [:show, :destroy]

 def search
   if params[:search].present?
     @videos = Video.search(params[:search])
     @musics = Music.highest_voted.limit(10)
      @videos = Video.highest_voted.limit(10)
      @facts = Fact.all.order('created_at DESC').limit(1)
      @abouts = About.all.order("created_at DESC").limit(1)


    @abouts = About.all.limit(1)

   else
     @videos = Video.all.order("created_at DESC")
   end
 end
  def index
    @videos = Video.all.order('created_at DESC')
    @abouts = About.all.order("created_at DESC").limit(1)
    @videos = Video.highest_voted.all.limit(10)
    @musics = Music.highest_voted.all.limit(10)
    @facts = Fact.all.order('created_at DESC').limit(1)


  end

def show
  @videos = Video.highest_voted.all.limit(10)
  @musics = Music.highest_voted.all.limit(10)
  @facts = Fact.all.order('created_at DESC').limit(1)
    @abouts = About.all.limit(1)

end

  def new
  @video = Video.new
end

def create
@video = Video.new(video_params)
  if @video.save
  flash = { success: "Congratulations!! Video Added Successfully", error: "Action Not Successfull." }
    redirect_to root_url
  else
    render 'new'
  end
end

def destroy
  @video.destroy
  redirect_to videos_url, notice: "video was removed"
end
def upvote
  @video = Video.find(params[:id])
  session[:voting_id] = request.remote_ip
  voter = Session.find_or_create_by(ip: session[:voting_id])
  voter.likes @video
  redirect_to :back
end

def downvote
  @video = Video.find(params[:id])
  session[:voting_id] = request.remote_ip
voter = Session.find_or_create_by(ip: session[:voting_id])
voter.dislikes @video
  redirect_to :back
end


  private
  def set_about
    @video = Video.find(params[:id])
  end


    def video_params
    params.require(:video).permit(:link, :title, :description, :story)
  end
end
