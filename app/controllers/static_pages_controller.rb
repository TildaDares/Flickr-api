class StaticPagesController < ApplicationController
  def home
    flickr = Flickr.new
    if params[:user_id]
      begin
        @photos = flickr.people.getPublicPhotos(:user_id => params[:user_id], :api_key => ENV['FLICKR_API_KEY'])
      rescue Flickr::FailedResponse
        flash[:alert] = 'User not found'
        @photos = flickr.photos.getRecent(:api_key => ENV['FLICKR_API_KEY'], :per_page => 48)
      end
    else
      @photos = flickr.photos.getRecent(:api_key => ENV['FLICKR_API_KEY'], :per_page => 48)
    end
  end
end
