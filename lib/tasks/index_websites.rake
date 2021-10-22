namespace :webcrawler do
    desc "Index websites"
    task index: :environment do

        starting_point = "https://www.unb.br/"
        # hrefs = get_hrefs(starting_point)

        response = HTTParty.get(starting_point, timeout: 20)
        doc = Nokogiri::HTML(response.body)
        puts extract_words(doc)

        # hrefs.each do |href|
        #   links = get_hrefs(href)
        # end unless hrefs.nil?

    end

    def get_hrefs url
        puts "Parsing URL: #{url}"

        print "Getting url..."
        begin
            response = HTTParty.get(url, timeout: 20)
        rescue Net::ReadTimeout
            print "Timout reached. Skipping\n"
            return nil
        rescue Net::OpenTimeout
            print "Timout reached. Skipping\n"
            return nil
        rescue
            print "Generic error. Skipping\n"
            return nil
        end

        return nil unless response.code == 200

        begin
            response.body.match?(/>([^<]+)/)
        rescue
            puts 'Unexpected error, skipping'
            return nil
        end

        print "  Done!\n"

        doc = Nokogiri::HTML(response.body)

        hrefs = []
        puts "Analyzing hrefs"
        doc.css('a').map do |link|
            if (href = link.attr('href')) and !href.empty?
                hrefs << href if valid_url?(href)
            end
        end

        puts "Parse complete, #{hrefs.size} links found"
        hrefs
    end

    def valid_url?(url)
        return false if url.include?("<script")
        url_regexp = /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix
        url =~ url_regexp ? true : false
    end

    def extract_words(nodes)
        texts = []
        nodes.traverse do |node|
            next unless node.is_a? Nokogiri::XML::Element

            texts << node.text
        end

        words = []
        texts.each do |text|
            words << text.split(/[^[[:word:]]]+/).uniq.reject(&:empty?)
        end

        words
    end
end
