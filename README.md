Jungle
======

About
-----

Jungle is a simple JRuby application demonstrating the integration of the powerful Java libraries and the awesome Ruby Gems. A mapping application with a simple search function in which you can search for contintents, countries, cities or streets. The maps are provided by OpenStreetMaps.

In this application I have used SwingX and SwingX-WS libraries provided by [SwingLabs](http://swinglabs.org/projects.jsp) for the mapping functionality and the [Geocoder](http://www.rubygeocoder.com/) Ruby gem for geocoding the addresses.

Running
-------

First install the dependencies with bundle:

	bundle

To start the application:

	rake

or

	jruby --1.9 jungle.rb
