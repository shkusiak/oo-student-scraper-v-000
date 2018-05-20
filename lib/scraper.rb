require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url)
    students = []

    doc.css("div.roster-card-container").each do |roster_card|
      roster_card.css(".student-card a").each do |student|
        student_name = student.css(".student_name").text
        student_location = student.css(".student-location").text
        student_url = student['href']

        students << {
          name: student_name,
          location: student_location,
          profile_url: student_url
        }
      end
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    student = {}

    links = doc.css("div.social-icon-container a").each do |social_icon|
      social_icon['href']
    end
    links.each do |link|
      if link.include?("twitter")
        student[:twitter] = link
      elsif link.include?("linkedin")
        student[:linkedin] = link
      elsif link.include?("github")
        student[:github] = link
      else
        student[:blog] = link
      end
    end

    student[:bio] = doc.css("div.bio-block div.description-holder p").text


  end

end
