require 'csv'
require 'fileutils'
require 'html_massage'

c = CSV.read('itest-xiezuo.csv', headers: false,)

# csv header
# ["标题和要求", "范文", nil, "分析", "考试类型", "附件"]

c_clean = c.map do |record|
  cleanup = record.map { |i| HtmlMassage.text i unless i.nil?}
  cleanup.to_csv(force_quotes: true)
end

File.write('itest-xiezuo-cleanup.csv', c_clean.join)

  
