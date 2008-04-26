== Title Helpers

Rails plugin providing helpers to set and show the site <title>.

== Examples

Show titles like

  <title><%= title("My Site") %></title>
  
For any page with no title defined, "My Site" will be used. You can, of course,
pull that root title from a constant, a configuration object or whatever.

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
  
== Author and License

By Henrik Nyh <http://henrik.nyh.se>.

Free to modify and redistribute with credit.
