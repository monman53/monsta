require 'nokogiri'
require 'net/http'
require 'set'

host = 'localhost'
root = 'http://' + host

# queue
q = [{from: 'tree-root', to: root + '/'}]
s = Set.new()

while !q.empty?
    qc = q.shift
    if s.include?(qc[:to])
        next
    end

    # GET request
    uri = URI.parse(qc[:to])
    f_ssl = true
    if uri.scheme == 'http'
        f_ssl = false
    end
    res = Net::HTTP.start(uri.host, uri.port, :use_ssl => f_ssl) do |http|
        http.get(uri.path)
    end

    # output status
    if res.code != '200'
        puts "\n[\e[31;1m" + res.code + "\e[m] " + qc[:from] + " -> \e[31;1m" + qc[:to] + "\e[m"
    else
        print '.'
        # puts "[\e[32m" + res.code + "\e[m] " + qc[:from] + " -> " + qc[:to]
    end
    s.add(qc[:to])

    # do not search outside of this host
    if uri.host != host
        next
    end

    # html parse
    document = Nokogiri::HTML.parse(res.body)
    document.xpath("//a").each do |tag|
        next_url = tag[:href]
        if URI.parse(next_url).host.to_s == ""
            next_url = root + next_url
        end
        if s.include?(next_url)
            next
        end
        # push next link
        q.push({from: qc[:to], to: next_url})
    end
end
