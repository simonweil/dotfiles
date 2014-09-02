
# Settings
Pry.config.color = true
Pry.config.prompt = Pry::NAV_PROMPT

# Commands
Pry.config.commands.alias_command "h", "hist -T 20", desc: "Last 20 commands"
Pry.config.commands.alias_command "hg", "hist -T 20 -G", desc: "Up to 20 commands matching expression"
Pry.config.commands.alias_command "hG", "hist -G", desc: "Commands matching expression ever used"
Pry.config.commands.alias_command "hr", "hist -r", desc: "hist -r <command number> to run a command"

begin
  require 'awesome_print'
  # Pry.config.print = proc { |output, value| Pry::Helpers::BaseHelpers.stagger_output("=> #{value.ai}", output) }
  # AwesomePrint.pry!
rescue LoadError => err
  puts "no awesome_print :("
end

=begin
begin
  require 'hirb'
rescue LoadError
  # Missing goodies, bummer
  puts "no hirb :("
end

if defined? Hirb
  # Slightly dirty hack to fully support in-session Hirb.disable/enable toggling
  Hirb::View.instance_eval do
    def enable_output_method
      @output_method = true
      @old_print = Pry.config.print
      Pry.config.print = proc do |output, value|
        Hirb::View.view_or_page_output(value) || @old_print.call(output, value)
      end
    end

    def disable_output_method
      Pry.config.print = @old_print
      @output_method = nil
    end
  end

  Hirb.enable
end
=end

puts "Loaded ~/.pryrc"
puts
puts "Helpful shortcuts:"
puts "h  : hist -T 20       Last 20 commands"
puts "hg : hist -T 20 -G    Up to 20 commands matching expression"
puts "hG : hist -G          Commands matching expression ever used"
puts "hr : hist -r          hist -r <command number> to run a command"
