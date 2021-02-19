require "link_to_me/version"
require "link_to_me/railtie" if defined?(Rails::Railtie)

module LinkToMe
  def self.included(klass)
    klass.class_eval do
      alias_method :_rails_link_to, :link_to
      remove_method :link_to
    end
  end
  # Creates an anchor element of the given +name+ using a URL created by the set of +options+.
  # See the valid options in the documentation for +url_for+. It's also possible to
  # pass a \String instead of an options hash, which generates an anchor element that uses the
  # value of the \String as the href for the link. Using a <tt>:back</tt> \Symbol instead
  # of an options hash will generate a link to the referrer (a JavaScript back link
  # will be used in place of a referrer if none exists). If +nil+ is passed as the name
  # the value of the link itself will become the name.
  #
  # ==== Signatures
  #
  #   link_to(body, url, html_options = {})
  #     # url is a String; you can use URL helpers like
  #     # posts_path
  #
  #   link_to(body, url_options = {}, html_options = {})
  #     # url_options, except :method, is passed to url_for
  #
  #   link_to(options = {}, html_options = {}) do
  #     # name
  #   end
  #
  #   link_to(url, html_options = {}) do
  #     # name
  #   end
  #
  #   link_to(active_record_model)
  #
  # ==== Options
  # * <tt>:data</tt> - This option can be used to add custom data attributes.
  # * <tt>method: symbol of HTTP verb</tt> - This modifier will dynamically
  #   create an HTML form and immediately submit the form for processing using
  #   the HTTP verb specified. Useful for having links perform a POST operation
  #   in dangerous actions like deleting a record (which search bots can follow
  #   while spidering your site). Supported verbs are <tt>:post</tt>, <tt>:delete</tt>, <tt>:patch</tt>, and <tt>:put</tt>.
  #   Note that if the user has JavaScript disabled, the request will fall back
  #   to using GET. If <tt>href: '#'</tt> is used and the user has JavaScript
  #   disabled clicking the link will have no effect. If you are relying on the
  #   POST behavior, you should check for it in your controller's action by using
  #   the request object's methods for <tt>post?</tt>, <tt>delete?</tt>, <tt>patch?</tt>, or <tt>put?</tt>.
  # * <tt>remote: true</tt> - This will allow the unobtrusive JavaScript
  #   driver to make an Ajax request to the URL in question instead of following
  #   the link. The drivers each provide mechanisms for listening for the
  #   completion of the Ajax request and performing JavaScript operations once
  #   they're complete
  #
  # ==== Data attributes
  #
  # * <tt>confirm: 'question?'</tt> - This will allow the unobtrusive JavaScript
  #   driver to prompt with the question specified (in this case, the
  #   resulting text would be <tt>question?</tt>. If the user accepts, the
  #   link is processed normally, otherwise no action is taken.
  # * <tt>:disable_with</tt> - Value of this parameter will be used as the
  #   name for a disabled version of the link. This feature is provided by
  #   the unobtrusive JavaScript driver.
  #
  # ==== Examples
  # Because it relies on +url_for+, +link_to+ supports both older-style controller/action/id arguments
  # and newer RESTful routes. Current Rails style favors RESTful routes whenever possible, so base
  # your application on resources and use
  #
  #   link_to "Profile", profile_path(@profile)
  #   # => <a href="/profiles/1">Profile</a>
  #
  # or the even pithier
  #
  #   link_to "Profile", @profile
  #   # => <a href="/profiles/1">Profile</a>
  #
  # in place of the older more verbose, non-resource-oriented
  #
  #   link_to "Profile", controller: "profiles", action: "show", id: @profile
  #   # => <a href="/profiles/show/1">Profile</a>
  #
  # Similarly,
  #
  #   link_to "Profiles", profiles_path
  #   # => <a href="/profiles">Profiles</a>
  #
  # is better than
  #
  #   link_to "Profiles", controller: "profiles"
  #   # => <a href="/profiles">Profiles</a>
  #
  # When name is +nil+ the href is presented instead
  #
  #   link_to nil, "http://example.com"
  #   # => <a href="http://www.example.com">http://www.example.com</a>
  #
  # Pithier yet, when name is an ActiveRecord model that defines a
  # +to_s+ method returning a name attribute or a default value
  #
  #   link_to @profile
  #   # => <a href="http://www.example.com/profiles/1">David</a>
  #
  # You can use a block as well if your link target is hard to fit into the name parameter. ERB example:
  #
  #   <%= link_to(@profile) do %>
  #     <strong><%= @profile.name %></strong> -- <span>Check it out!</span>
  #   <% end %>
  #   # => <a href="/profiles/1">
  #          <strong>David</strong> -- <span>Check it out!</span>
  #        </a>
  #
  # Classes and ids for CSS are easy to produce:
  #
  #   link_to "Articles", articles_path, id: "news", class: "article"
  #   # => <a href="/articles" class="article" id="news">Articles</a>
  #
  # Be careful when using the older argument style, as an extra literal hash is needed:
  #
  #   link_to "Articles", { controller: "articles" }, id: "news", class: "article"
  #   # => <a href="/articles" class="article" id="news">Articles</a>
  #
  # Leaving the hash off gives the wrong link:
  #
  #   link_to "WRONG!", controller: "articles", id: "news", class: "article"
  #   # => <a href="/articles/index/news?class=article">WRONG!</a>
  #
  # +link_to+ can also produce links with anchors or query strings:
  #
  #   link_to "Comment wall", profile_path(@profile, anchor: "wall")
  #   # => <a href="/profiles/1#wall">Comment wall</a>
  #
  #   link_to "Ruby on Rails search", controller: "searches", query: "ruby on rails"
  #   # => <a href="/searches?query=ruby+on+rails">Ruby on Rails search</a>
  #
  #   link_to "Nonsense search", searches_path(foo: "bar", baz: "quux")
  #   # => <a href="/searches?foo=bar&baz=quux">Nonsense search</a>
  #
  # The only option specific to +link_to+ (<tt>:method</tt>) is used as follows:
  #
  #   link_to("Destroy", "http://www.example.com", method: :delete)
  #   # => <a href='http://www.example.com' rel="nofollow" data-method="delete">Destroy</a>
  #
  # You can also use custom data attributes using the <tt>:data</tt> option:
  #
  #   link_to "Visit Other Site", "http://www.rubyonrails.org/", data: { confirm: "Are you sure?" }
  #   # => <a href="http://www.rubyonrails.org/" data-confirm="Are you sure?">Visit Other Site</a>
  #
  # Also you can set any link attributes such as <tt>target</tt>, <tt>rel</tt>, <tt>type</tt>:
  #
  #   link_to "External link", "http://www.rubyonrails.org/", target: "_blank", rel: "nofollow"
  #   # => <a href="http://www.rubyonrails.org/" target="_blank" rel="nofollow">External link</a>
  def link_to(name = nil, options = nil, html_options = nil, &block)
    html_options, options, name = options, name, block if block_given?
    options ||= {}

    html_options = convert_options_to_data_attributes(options, html_options)

    url = url_for(url_target(name, options))
    html_options["href"] ||= url

    content_tag("a", name || url, html_options, &block)
  end

  private
    def url_target(name, options)
      if name.respond_to?(:model_name) && options.empty?
        url_for(name)
      else
        url_for(options)
      end
    end
end
