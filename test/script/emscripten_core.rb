#!/usr/bin/evn ruby
# -*- coding: utf-8 -*-

require 'open3'
require 'timeout'

ROOT_PATH = File.expand_path('.')
TARGET_FILE = File.join(ROOT_PATH, 'src', 'usagi')
CONFIG_FILE = File.join(ROOT_PATH, 'test', 'script', 'application.json')
WORK_FILE = File.join(ROOT_PATH, 'work')
EMSCRIPTEN_CORE_PATH = File.join(ROOT_PATH, 'test', 'emscripten', 'core')
# *.llファイルの格納場所
LL_PATH = File.join(EMSCRIPTEN_CORE_PATH, 'll')

# llファイルそれぞれを実行する
Dir.chdir(LL_PATH) do
  File.open(File.join(WORK_FILE, 'log.txt'), 'w') do |log|
    
    Dir.glob("*.ll") do |fname|
      puts File.join(LL_PATH, fname)
      out = ''
      stdin, stdout, stderr, thrl =
        *Open3.popen3("#{TARGET_FILE} -c #{CONFIG_FILE} -l #{File.join(LL_PATH, fname)}")

      begin
        Timeout.timeout(180) do
          # 標準入力はさっさと閉じる
          stdin.close()
        
          # 標準エラーの内容を出力
          File.open(File.join(WORK_FILE, fname) + '.err', 'w') do |f|
            # puts stderr.read()
            f << stderr.read()
          end
          
          # 標準出力の内容を出力
          File.open(File.join(WORK_FILE, fname) + '.out', 'w') do |f|
            # puts stdout.read()
            out << stdout.read();
            f << out
          end
        end # timeout
        
        # 終了ステータスのエラー判定
        if (not thrl.value.success?) then
          log << fname << "\tabort\n"
          
        else
          # 標準出力の内容がテストケースと同じかどうか比較
          is_success = false
          Dir.chdir(EMSCRIPTEN_CORE_PATH) do
            Dir.glob("#{File.basename(fname, ".ll")}.{txt,out}") .each do |fname_test|
              test = File.read(fname_test)
              is_success = true if test == out
            end
          end
          if is_success then
            log << fname << "\tsuccess\n"
          else
            log << fname << "\tmissmatch\n"
          end
        end
        
      rescue Timeout::Error => e
        begin
          Process.kill("KILL", thrl.pid)  
        rescue => e
          p e
        end
        log << fname << "\ttimeout\n"
      end

    end
  end
end
