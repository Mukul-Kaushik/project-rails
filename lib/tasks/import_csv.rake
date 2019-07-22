require 'csv'
desc 'Import CSV'
task import_csv: :environment do
  count=0
  total_count=0;
  CSV.foreach('mydata.csv', headers: :true) do |row|
    total_count+=1
    candidate_hash=row.to_h
    candidate_hash["id"]=candidate_hash["registration_number"].split("/")[2]
    candidate=Candidate.new(candidate_hash)
    if candidate.save
      count+=1
    end
  end
  puts "Imported #{count} Candidates from #{total_count}"
end