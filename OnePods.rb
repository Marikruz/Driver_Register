# note: new generation of one pods integration file.
# author: zengbeibei_i@didiglobal.com
# !/usr/bin/ruby
require 'json'

one_path = `which one`
lib = File.expand_path('../../lib', one_path)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'onetool/onepods/onepods'

# SDK PODS
def load_pods
    # 三方依赖
    pod_one 'ONENetworking', bin: false, git: 'git@git.xiaojukeji.com:one-ios/ONENetworking.git', tag: '1.6.0', enable: true
end
