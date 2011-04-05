# encoding: utf-8
module Kmr

  class << self

    def calculate_dbf(text)
      dbf, v = [], []
      l, n, pot = 1, text.size, 1

      poz = (0...n).to_a
      n.times { |i| dbf[i] = [] }
      dbf[0] = text.split("").map { |c| c.bytes.first }

      while(pot < n)
        0.upto(n-pot-1) { |i| v[i] = [ dbf[l-1][i], dbf[l-1][i+pot] ] }
        (n-pot).upto(n-1) { |i| v[i] = [dbf[l-1][i], 10000] }

        poz.sort! do |a, b|
          v[a].first == v[b].first ? v[a].last <=> v[b].last : v[a].first <=> v[b].first
        end

        akt = 1

        n.times do |i|
          dbf[l][poz[i]] = akt;
          tmp = poz[i+1] || 0
          akt += 1 if v[poz[i]] != v[tmp]
        end

        l += 1
        pot *= 2
      end

      dbf.reject! { |e| e == [] }
      dbf
    end

    def longest_repeated_substring(text)
      dbf = calculate_dbf(text)
      n = text.size
      results, last_occurance, row, base_row = [], {}, [], nil
      max_length, words, columns, v = -1, [], [], []

      dbf_ok = {}

      dbf.each_with_index do |dbf_row, i|
        dbf_ok[2**i] = dbf_row
      end

      from = 1
      to = n/2+1

      poz = (0...n).to_a

      while(from + 1 < to)
        j = (from+to)/2
        base_row_id = 2**((Math.log(j)/Math.log(2)).floor)
        base_row = dbf_ok[base_row_id]

        if j == base_row_id
          row = base_row
        else
          n.times do |c|
            v[c] = [ base_row[c], base_row[c+j-base_row_id] ]
          end

          poz.sort! do |a, b|
            v[a].first == v[b].first ? v[a].last <=> v[b].last : v[a].first <=> v[b].first
          end

          akt = 1
          n.times do |k|
            row[poz[k]] = akt;
            tmp = poz[k+1] || 0
            akt += 1 if v[poz[k]] != v[tmp]
          end
        end

        results, last_occurance, columns, new_words = {}, {}, [], []

        row.each_with_index do |e, k|
          if !last_occurance[e] || last_occurance[e] + j - 1 < k
            if results[e]
              results[e][0] += 1
            else
              results[e] = [1, k]
            end
            last_occurance[e] = k
          end
        end

        results.each do |id, quantity|
          if quantity.first >= 2 && j > max_length
            max_length = j
            columns = [[id, quantity]]
            words = []
          elsif quantity.first >= 2 && j == max_length
            columns << [id, quantity]
          end
        end

        if columns.size > 0
          new_words = columns.map { |c| text[c.last.last, max_length] }
          from = j
          words = new_words
        else
          to = j
        end
      end

      words.uniq
    end
  end
end
