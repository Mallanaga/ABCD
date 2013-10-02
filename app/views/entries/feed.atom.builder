atom_feed language: 'en-US', schema_date: 2013 do |feed|
  feed.title @title
  feed.updated @updated

  @entries.each do |e|
    next if e.updated_at.blank?
    feed.entry e do |entry|
      entry.title e.name
      entry.summary e.summary.blank? ? truncate("#{strip_tags(e.content)}", length: 140, separator: ' ') : strip_tags(e.summary)
      entry.content e.content, type: 'html'
      entry.author do |author|
        author.name e.user.name
      end
      e.categories.map {|c| c.name}.each do |t|
        entry.category term: t, label: t, scheme: 'alphabeticdesign.com'
      end
      entry.category term: 'blog', label: 'blog', scheme: 'alphabeticdesign.com'
    end # end feed.entry
  end # end @entries.each

  @designs.each do |d|
    next if d.updated_at.blank?
    feed.entry d do |entry|
      entry.title d.name
      entry.summary truncate("#{strip_tags(d.content)}", length: 140, separator: ' ')
      entry.content d.content, type: 'html'
      entry.author do |author|
        author.name User.first.name
      end
      d.categories.map {|c| c.name}.each do |t|
        entry.category term: t, label: t, scheme: 'alphabeticdesign.com'
      end
      entry.category term: 'design', label: 'design', scheme: 'alphabeticdesign.com'
    end # end feed.entry
  end # end @designs.each
end