atom_feed language: 'en-US', schema_date: 2013 do |feed|
  feed.title @title
  feed.updated @updated

  @entries.each do |e|
    next if e.updated_at.blank?
    feed.entry e do |entry|
      entry.title e.title
      entry.summary e.summary.blank? ? truncate("#{strip_tags(e.content)}", length: 140, separator: ' ') : strip_tags(e.summary)
      entry.content e.content, type: 'html'
      entry.link href: entry_url(e)
      entry.author do |author|
        author.name e.user.name
      end
      e.categories.map {|c| c.name}.each do |t|
        entry.category term: t, label: t, scheme: 'alphabeticdesign.com'
      end
    end # end feed.entry
  end # end @entries.each
end