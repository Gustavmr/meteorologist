require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]
    url_safe_street_address = URI.encode(@street_address)

    # ==========================================================================
    # Your code goes below.
    # The street address the user input is in the string @street_address.
    # A URL-safe version of the street address, with spaces and other illegal
    #   characters removed, is in the string url_safe_street_address.
    # ==========================================================================

    # long and lat retrieve
    coordurl = 'http://maps.googleapis.com/maps/api/geocode/json?address='+url_safe_street_address
    coordata = JSON.parse(open(coordurl).read)
    lat = coordata['results'][0]['geometry']['location']['lat']
    lng = coordata['results'][0]['geometry']['location']['lng']

    # weather retrieve
    w_url = 'https://api.forecast.io/forecast/592ac17e5e342d46ae1ecddf22c69ca6/' + lat.to_s + ',' + lng.to_s
    w_data = JSON.parse(open(w_url).read)

    @current_temperature = w_data['currently']['temperature']

    @current_summary = w_data['currently']['summary']

    @summary_of_next_sixty_minutes = w_data['minutely']['summary']

    @summary_of_next_several_hours = w_data['hourly']['summary']

    @summary_of_next_several_days = w_data['daily']['summary']

    render("street_to_weather.html.erb")
  end
end
