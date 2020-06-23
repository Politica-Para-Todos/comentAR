# frozen_string_literal: true

require 'json'
require 'open-uri'

namespace :data do
  task :populate, [:json_path] => :environment do |_t, args|
    json_path = args[:json_path] || './db/seeds.json'

    json_file = open(json_path)
    json = JSON.parse(json_file.read)

    json.fetch('parties').each do |party_acronym, party|
      p = Party.find_or_initialize_by(acronym: party_acronym)

      p.description = party.fetch('description')
      p.description_source = party.fetch('description_source')
      p.email = party.fetch('email')
      p.facebook = party.fetch('facebook')
      p.instagram = party.fetch('instagram')
      p.twitter = party.fetch('twitter')
      p.website = party.fetch('website')
      p.logo = "/images/party_logos/#{party.fetch('logo')}"
      p.name = party.fetch('name')

      puts "Party #{p.acronym} updated!" if p.save

      party.fetch('candidates', []).each do |district, candidate_types|
        candidate_types.each do |candidate_type, candidates|
          candidates.each do |candidate|
            c = Candidate.find_or_initialize_by(
              party_id: p.id,
              district: district,
              position: candidate.fetch('position'),
              candidate_type: candidate.fetch('type')
            )

            c.name = candidate.fetch('name')
            c.biography = candidate.fetch('biography', nil)
            c.biography_source = candidate.fetch('biography_source', nil)
            c.is_lead_candidate = candidate.fetch('is_lead_candidate')
            c.link_parlamento = candidate.fetch('link_parlamento', nil)
            photo = candidate.fetch('photo', nil)
            c.photo = photo.nil? ? "" : "/images/party_candidates/#{photo}"
            c.photo_source = candidate.fetch('photo_source', nil)

            puts "Candidate #{c.name} updated!" if c.save
          end
        end
      end
    end

    json.fetch('manifestos').each do |party_acronym, manifesto|
      # CDU does not have manifesto, instead we have manifestos for PCP and PEV
      p = Party.find_or_initialize_by(acronym: party_acronym)
      p.save
      m = Manifesto.find_or_initialize_by(party_id: p.id)

      m.title = manifesto.fetch('title')

      puts "Manifesto #{p.acronym} updated!" if m.save

      manifesto.fetch('sections').each do |section|
        s = ManifestoSection.find_or_initialize_by(
          position: section.fetch('position'),
          manifesto_id: m.id,
          manifesto_section_id: nil
        )

        s.title = section.fetch('title')

        puts "ManifestoSection #{s.title} updated!" if s.save

        content = section.fetch('content')
        if content[0].key?("html")
          content.each do |item|
            i = ManifestoItem.find_or_initialize_by(
              position: item.fetch('position'),
              manifesto_section_id: s.id,
              uuid: item.fetch('uuid', nil)
            )

            i.content = item.fetch('html')

            puts "ManifestoItem #{i.position} updated!" if i.save
          end
        else
          content.each do |subsection|
            subs = ManifestoSection.find_or_initialize_by(
              position: subsection.fetch('position'),
              manifesto_id: m.id,
              manifesto_section_id: s.id
            )

            subs.title = subsection.fetch('title')

            puts "ManifestoSection #{subs.manifesto_section_id}-#{subs.position} updated!" if subs.save

            subsection.fetch('content').each do |item|
              i = ManifestoItem.find_or_initialize_by(
                position: item.fetch('position'),
                manifesto_section_id: subs.id,
                uuid: item.fetch('uuid', nil)
              )

              i.content = item.fetch('html')

              puts "ManifestoItem #{subs.id}-#{i.position} updated!" if i.save
            end
          end
        end
      end
    end
  end
end
