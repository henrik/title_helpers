== Title Helpers

Rails plugin providing helpers to set and show the site <title>.

== Examples

Show titles like

  <title><%= title("My Site") %></title>
  
For any page with no title defined, "My Site" will be used. You can, of course,
get that root title from a constant, a configuration object or whatever.

The helper applies h() so you don't have to.

Define titles like

  self.title = "Welcome"
  
in a controller or

  <% self.title = "Welcome" %>

in a view. The above example would give "Welcome – My Site".

If you do not want the page suffix for a particular page, do e.g.

  self.full_title = "Welcome"
  
which would give "Welcome". You can use "%s" to substitute the suffix when
using full_title:

  self.full_title = "Welcome to %s!"
  
gives "Welcome to My Site!"

Since the provided full_title is treated as a format string (with %s), remember
to escape any non-format string percentage signs by doubling them:

  self.full_title = "Welcome to %s – 100%% French bulldogs"
  
gives "Welcome to My Site – 100% French bulldogs".

If your full_title contains user-provided data, you can use the format_string_escape
(or fs_escape for short) helper:

  user.name = "%see%my%vest%"
  self.full_title = "#{fs_escape user.name} on %s"
  
When using title=, data is automatically escaped, since format strings can only be
used with full_title:

  user.name = "%see%my%vest%"
  self.title = user.name
  
gives "%see%my%vest% – My Site".
  
== Author and License

By Henrik Nyh <http://henrik.nyh.se>.

Free to modify and redistribute with credit.
