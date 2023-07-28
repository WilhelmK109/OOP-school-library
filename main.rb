require_relative 'app'

def entry_point
  app = App.new
  app.start
end

entry_point if $PROGRAM_NAME == __FILE__
