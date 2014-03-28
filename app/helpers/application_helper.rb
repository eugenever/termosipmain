module ApplicationHelper

  def youtube_video(url)
    render :partial => 'shared/youtube', :locals => { :url => url }
  end 
  
end
