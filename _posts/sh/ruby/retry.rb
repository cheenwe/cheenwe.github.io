retry_num = 0
begin
	a>1
rescue Exception => e
	raise if retry_num >= 3
	retry_num += 1
	puts "#{retry_num}.failure: #{e}, retrying...."
	sleep(2 ** retry_num)

	retry
end

