module ApplicationHelper
  
  # Sets the page title and outputs title if container is passed in.
  # eg. <%= title('Hello World', :h2) %> will return the following:
  # <h2>Hello World</h2> as well as setting the page title.
  def title(str, container = nil)
    @page_title = str
    content_tag(container, str) if container
  end
  
  # Outputs the corresponding flash message if any are set
  def flash_messages
    messages = []
    %w(notice warning error).each do |msg|
      messages << content_tag(:div, html_escape(flash[msg.to_sym]), :id => "flash-#{msg}") unless flash[msg.to_sym].blank?
    end
    messages
  end
  
  def logged_in?
       session[:email] && session[:password]
     end

    # Is this from a Polycom phone?
    def polycom_user_agent?
      request.env["HTTP_USER_AGENT"] && request.env["HTTP_USER_AGENT"][/PolycomSoundPointIP/]
    end



     def logout
       link_to "Logout", :controller => "sessions", :action => "destroy"
     end
     def dashboard
       link_to "Dashboard", :controller => "dashboard", :action => "index" 
     end

     def format_phone_number(phone_number)
       phone_number = phone_number.to_s
       match = phone_number.match /^1(\d{3})(\d{3})(\d{4})$/
       return phone_number unless match
       npa, nxx, xxxx = match.captures
       "1 (#{npa}) #{nxx}-#{xxxx}"
     end

     def humanize_hour(hour)
       if hour == 0
         "12am"
       elsif hour < 12
         "#{hour}am"
       elsif hour == 12
         "12pm"
       else
         "#{hour - 12}pm"
       end
     end
  
  
end
