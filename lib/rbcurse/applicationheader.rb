require 'rbcurse/rwidget'
include Ncurses
include RubyCurses
module RubyCurses
  class ApplicationHeader < Widget
    dsl_property :text1
    dsl_property :text2
    dsl_property :text_center
    dsl_property :text_right


    def initialize form, text1, config={}, &block

      @text1 = text1
      # setting default first or else Widget will place its BW default
      @color, @bgcolor = ColorMap.get_colors_for_pair $bottomcolor
      super form, config, &block
      @color_pair = get_color $bottomcolor, @color, @bgcolor
      @window = form.window
      @editable = false
      @focusable = false
      @cols ||= Ncurses.COLS-1
      @row ||= 0
      @col ||= 0
      @repaint_required = true
      #@color_pair ||= $bottomcolor  # XXX this was forcing the color
      #pair
      @text2 ||= ""
      @text_center ||= ""
      @text_right ||= ""
    end
    def getvalue
      @text1
    end

    ##
    # XXX need to move wrapping etc up and done once. 
    def repaint
      return unless @repaint_required
 
      #print_header(htext, posy = 0, posx = 0)
      print_header(@text1 + " %15s " % @text2 + " %20s" % @text_center , posy=0, posx=0)
      print_top_right(@text_right)
      @repaint_required = false
    end
    def print_header(htext, r = 0, c = 0)
    $log.debug " def print_header(#{htext}, posy = 0, posx = 0)"
      win = @window
      len = Ncurses.COLS-0
      @form.window.printstring r, c, "%-*s" % [len, htext], @color_pair, @attr
    end
    def print_top_right(htext)
    $log.debug " def print_top_right(#{htext})"
      hlen = htext.length
      len = Ncurses.COLS-1
      @form.window.printstring 0, len-hlen, htext, @color_pair, @attr
    end
    ##
    ##
    # ADD HERE 
  end
end
