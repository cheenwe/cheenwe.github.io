require 'net/ftp'
require 'fileutils'
ftp_host = "47.101.1.1"
ftp_port = 21
ftp_user = "ftp_user"
ftp_pwd = "password"
ftp_mode = true
ftp_path = "awos"
local_path = "awos"
file_attr = "*.ZSPD"

@ftp = Net::FTP.new
@ftp.connect(ftp_host, ftp_port)
@ftp.login(ftp_user, ftp_pwd)
@ftp.passive = ftp_mode
#print(@ftp)
@ftp.chdir(ftp_path)
lists = @ftp.nlst(file_attr)
print(lists)
@local_path = local_path + "/" + Time.now.strftime('%Y-%m-%d')
#@local_path = local_path + "/" + "2020-02-18"
# 获取服务器上确切名称的文件
# 例如： get("test/test.txt")
def log_info(info)
  printf(info)
end

#本地路径
def local_file(file)
  local = File.join(@local_path, file)
  FileUtils.makedirs(File.dirname(local))
  local
end
# 删除本地文件
def delete_local_file(file)
  if File.exist?(file)
    log_info("delete local file : " + file)
    File.delete(file)
  end
end
# 重命名本地文件
def rename_local_file(origin_file, file)
  if File.exist?(origin_file)
    log_info("rename local file : " + origin_file + " to " + file)
    File.rename(origin_file, file)
  end
end
# 删除服务器上的文件
def delete(origin_file)
  if not @ftp.list(origin_file).blank?
    log_info("FTP delete #{origin_file}")
    @ftp.delete(origin_file)
  end
end

# 获取指定格式的文件名称列表
# 例如： source = "test/*.txt"
# 返回： [source/file_name.txt]
def fetch_remote_filenames(source)
  return [] if source.blank?
  log_info("source is " + source)
  filenames = @current_ftp.nlst(source)
  filenames
end

# 上传文件到指定的路径
# 例如： put("tmp\\test\\test.txt", "/test/")
def put(origin_file, remote_path)
  return nil if not File.exist?(origin_file)
  _file_name = File.basename(origin_file)
  _root = @current_ftp.getdir
  @current_ftp.chdir(remote_path)
  log_info("Ftp put: #{origin_file} -> #{remote_path}")
  begin
    @current_ftp.putbinaryfile(origin_file, remote_path + _file_name + ".tmp")
  rescue
    delete(remote_path + _file_name + ".tmp")
  end
  @current_ftp.chdir(_root)
  rename(remote_path + _file_name + ".tmp", remote_path + _file_name)
end

# 关闭ftp
def close
  @current_ftp.close if @current_ftp
end
# 服务器copy文件
def copy(origin_file, file_path)
  local_file = local_file(origin_file)
  _file_name = File.basename(origin_file)
  begin
    #1. 到本地
    log_info("FTP get file to:" + local_file+".tmp")
    @current_ftp.getbinaryfile(origin_file, local_file+".tmp")
    return nil if not File.exist?(local_file+".tmp")
    #2. 到服务器
    log_info("FTP put file to :" + file_path + _file_name + ".tmp")
    @current_ftp.putbinaryfile(local_file+".tmp", file_path + _file_name + ".tmp")
    #3. 改名字
    rename(file_path + _file_name + ".tmp", file_path + _file_name)
    #5. 删除本地
    delete_local_file(local_file + ".tmp")
  rescue => e
    log_info(e)
    #4. 删除服务器上临时文件
    delete(file_path + origin_file + ".tmp")
    #5. 删除本地
    delete_local_file(local_file + ".tmp")
  end
end
# 服务器上移动文件
def move(origin_file, file_path)
  _file_name = File.basename(origin_file)
  begin
    copy(origin_file, file_path)
    # 删除服务器上源文件
    delete(origin_file)
  rescue => e
    log_info(e)
    # 删除临时文件，如果存在
    delete(file_path + _file_name + ".tmp")
    # 删除服务器上目标文件， 如果存在
    delete(file_path + _file_name)
  end
end
# 重命名服务器文件
def rename(origin_file, file)
  if not @current_ftp.list(origin_file).blank?
    log_info("FTP rename #{origin_file} to #{file}")
    @current_ftp.rename(origin_file, file)
  end
end
# 删除服务器上的文件
def delete(origin_file)
  if not @current_ftp.list(origin_file).blank?
    log_info("FTP delete #{origin_file}")
    @current_ftp.delete(origin_file)
  end
end

# ftp 是否关闭
def closed?
  @current_ftp.closed?
end

# ftp 是否关闭
def closed?
  @ftp.closed?
end
# 文件将被保存到本地 tmp/test/test.txt
def save_file(origin_file)
  local_file = local_file(origin_file)
  local_file.gsub("//", "////") #此处注意是window下执行， 在linux下需要注意改成/
  log_info("Ftp Get: #{origin_file} -> #{local_file}")
  begin
    @ftp.getbinaryfile(origin_file, local_file+".tmp")
  rescue
    delete_local_file(local_file+".tmp")
  end
    rename_local_file(local_file+".tmp", local_file) if File.exist?(local_file+".tmp")
  end

lists.each do |file|
  p file
    if File.exists?(local_file(file)) == true
    p "数据存在，已跳过.."
  else
      save_file(file)
      # aFile = File.new("#{@local_path}/list.txt","a+")
      # aFile.puts "192.168.50.51/03.qixiang/cappi/" + local_file(file)
      # aFile.close
  end
end
