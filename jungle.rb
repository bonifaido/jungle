# Ruby
require 'geocoder'

# Java
require 'java'
require 'lib/swingx-1.6.jar'
require 'lib/swingx-ws-1.0.jar'

java_import 'java.util.HashSet'
java_import 'java.awt.BorderLayout'
java_import 'javax.swing.JFrame'
java_import 'javax.swing.JPanel'
java_import 'javax.swing.JTextField'
java_import 'org.jdesktop.swingx.JXMapKit'
java_import 'org.jdesktop.swingx.mapviewer.GeoPosition'
java_import 'org.jdesktop.swingx.mapviewer.Waypoint'
java_import 'org.jdesktop.swingx.mapviewer.WaypointPainter'


module Geocoder
  module Result

    class Base
      def to_geopos
        GeoPosition.new latitude, longitude
      end
    end

  end
end

module Jungle
  
  class MainWindow < JFrame
    def initialize
      super "Jungle"
      set_size(640, 400)
      set_location_relative_to nil
      set_default_close_operation EXIT_ON_CLOSE
      set_layout BorderLayout.new

      mapkit = MapKit.new
      text_field = JTextField.new 20
      text_field.set_horizontal_alignment JTextField::CENTER

      text_field.add_action_listener do |event|
        name = text_field.text
        if result = Geocoder.search(name).first
          text_field.text = result.address
          geopos = result.to_geopos
          mapkit.get_main_map.center_position = geopos
          mapkit.waypoints = [Waypoint.new(geopos)]
        end
      end

      panel = JPanel.new
      panel.add text_field
      add mapkit, BorderLayout::CENTER
      add panel, BorderLayout::SOUTH
    end
  end

  class MapKit < JXMapKit
    def initialize
      super
      set_default_provider JXMapKit::DefaultProviders::OpenStreetMaps
      @waypoint_painter = WaypointPainter.new
      get_main_map.set_overlay_painter @waypoint_painter
    end
  
    def waypoints=(waypoints)
      @waypoint_painter.set_waypoints(HashSet.new(waypoints))
    end
  end

end


Geocoder::Configuration.cache = {}

Jungle::MainWindow.new.set_visible true
