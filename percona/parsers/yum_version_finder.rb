# frozen_string_literal: true

require 'mechanize'

module Percona
  # Find version
  # Usage: `./bin/parser percona yum_version_finder 0.1 | grep Matched`
  class YumVersionFinder < Dry::CLI::Command
    desc 'Search download rpm url links for specific version.'

    argument :version, required: true, desc: 'Searchable version download url'
    argument :url, default: 'https://repo.percona.com/yum', desc: 'URL of percona repo for parse'

    def call(version:, url:, **)
      @results = []
      search(url, version)

      if @results.length.positive?
        puts "\n"
        puts 'Results:'
        puts @results
      else
        puts 'Matches Not Found(('
      end
    end

    def search(url, version)
      page = agent.get(url)
      puts "Proceed: #{page.uri}"

      page.links.each do |link|
        next unless rpm_download?(link) || (directory?(link) && !parent_dir?(link))

        if rpm_download?(link) && findable_link?(link, version)
          link_full_uri = link.resolved_uri
          puts "Matched: #{link_full_uri}"
          @results << link_full_uri
        elsif directory?(link)
          search(link, version)
        end
      end
    rescue Mechanize::ResponseCodeError => e
      puts e
    end

    private

    def findable_link?(link, version)
      link.to_s.include?(version)
    end

    def rpm_download?(link)
      link.to_s.match?(/\.rpm$/)
    end

    def directory?(link)
      link.to_s.match?(/\/$/)
    end

    def parent_dir?(link)
      link.to_s.match?(/Parent directory/)
    end

    def agent
      @agent ||= Mechanize.new
    end
  end
end
