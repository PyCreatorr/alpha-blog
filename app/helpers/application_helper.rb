module ApplicationHelper
    # Function for gravatar image on the users/show.html.erb
    # If no size provided -> default size is 80
    def gravatar_for(user, options = {size: 80}) 
        email_address = user.email.downcase
        hash = Digest::MD5.hexdigest(email_address)
        size = options[:size]
        gravatar_url = "https://www.gravatar.com/avatar/#{hash}?s=#{size}"
        image_tag(gravatar_url, alt: user.username, class: "rounded")
    end
end
