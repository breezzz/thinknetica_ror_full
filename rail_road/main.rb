#! /usr/bin/env ruby

require_relative 'application'

app = Application.new
loop do
  m = app.main_menu
  break if m.zero?
  app[app.menu_methods[m - 1]]
end
