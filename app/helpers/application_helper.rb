module ApplicationHelper
  
  # Sets the page title and outputs title if container is passed in.
  # eg. <%= title('Hello World', :h2) %> will return the following:
  # <h2>Hello World</h2> as well as setting the page title.
  def title(str)
    @page_title = str
    content_tag :h1, :class => "hide" do 
      str
    end
  end  
  
  # Adds an CSS class named 'active', if it's the active link
  # Will not be able to handle blocks, like link_to 
  def link_to_with_class(*args)
    options = args.second || {}
    url = url_for(options)
    extra_args = {:id => (current_page?(url) ? 'current' : '' )}
    link_to(*args << extra_args)
  end
  
  # Outputs the corresponding flash message if any are set
  def flash_messages
    messages = []
    %w(notice warning error).each do |msg|
      messages << content_tag(:div, html_escape(flash[msg.to_sym]), :id => "flash-#{msg}") unless flash[msg.to_sym].blank?
    end
    messages
  end
  
end
