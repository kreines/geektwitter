module TweetsHelper
  def find_youtube_url(youtube_url)
    return nil if youtube_url.blank?  # nilや空文字なら即return

    if youtube_url[0..16] == "https://youtu.be/"
      youtube_url[17..27] # 11桁の動画IDを返す
    else
      nil
    end
  end
end
