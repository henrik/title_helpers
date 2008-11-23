# Title Helpers

Rails plugin providing helpers to set and show the site `<title>`.


## Showing the title

Show titles like

    <title><%= title("My Site") %></title>
  
where "My Site" is your base title. If no custom title has been set for the current page, the returned title will just be that base title (except in development – see below).

You can provide the base title inline, like above. You could also, of course, provide it from a constant or a configuration object that you set up in an initializer, e.g.

    <title><%= title(SITE_TITLE) %></title>
    
Your views and controllers can set title prefixes ("Welcome – My Site") as well as override the full title ("Welcome to My Site!").

You can use `title` without an argument to get just the title prefix. This is handy for headers:

    <% self.title = "Welcome" %>

    <title><%= title("My Site")</title>
    ⋮
    <h1><%= title %></h1>
  
will give the title "Welcome – My Site" and the header "Welcome".

You could even do something like

    <% self.title = "Welcome" %>
    <% self.full_title = "Welcome to %s!" %>

    <title><%= title("My Site")</title>
    ⋮
    <h1><%= title %></h1>

to set the full title to "Welcome to My Site!" and the header to "Welcome".

The `title` helper applies `h` so you don't have to.


## Setting the title

Define titles like

    self.title = "Welcome"
  
in a controller or

    <% self.title = "Welcome" %>

in a view. The above example would give "Welcome – My Site".

If you do not want the page suffix for a particular page, do e.g.

    self.full_title = "Welcome"
  
which would give "Welcome". You can use "%s" to substitute the base title when
using `full_title`:

    self.full_title = "Welcome to %s!"
  
gives "Welcome to My Site!"

Since the `full_title` is treated as a format string (with %s), remember
to escape any non-format string percentage signs by doubling them:

    self.full_title = "Welcome to %s – 100%% French bulldogs"
  
gives "Welcome to My Site – 100% French bulldogs".

If your `full_title` contains dynamic data, you can use the `format_string_escape`
(or `fs_escape` for short) helper:

    user.name = "%see%my%vest%"
    self.full_title = "#{fs_escape user.name} on %s"
  
When using `title=`, data is automatically escaped, since format strings can only be
used with `full_title`:

    user.name = "%see%my%vest%"
    self.title = user.name
  
gives "%see%my%vest% – My Site".


## Title hints in development

If no title has been set for a page, the base title will be shown. *In development*, however, you will see

    ~ PLEASE SET A TITLE ~
    
This is intended to help you remember to title every page. If you really just wanted the
base title on a page and do not want to see this helpful hint, just do

    self.title!
    
If you never want these hints, set

    TitleHelpers.hints = false
    
The recommended place for configuring the plugin is a `config/initializers/plugins.rb` file.


## Tips

You can override the `title=` method in your controllers to e.g. get a common prefix:

    class UsersController < ApplicationController

    protected

      def title=(title)
        title = "User: #{title}"
        super(title)
      end

    end
    
Now you can do

    self.title = @user.name
    
from the controller or its views, to get titles like "User: User Name – My Site".
  
## Credits and license

By [Henrik Nyh](http://henrik.nyh.se/) under the MIT license:

>  Copyright (c) 2008 Henrik Nyh
>
>  Permission is hereby granted, free of charge, to any person obtaining a copy
>  of this software and associated documentation files (the "Software"), to deal
>  in the Software without restriction, including without limitation the rights
>  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
>  copies of the Software, and to permit persons to whom the Software is
>  furnished to do so, subject to the following conditions:
>
>  The above copyright notice and this permission notice shall be included in
>  all copies or substantial portions of the Software.
>
>  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
>  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
>  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
>  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
>  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
>  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
>  THE SOFTWARE.
