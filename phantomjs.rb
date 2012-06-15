require 'formula'

class SnowLeopardOrNewer < Requirement
  def satisfied?
    MacOS.snow_leopard?
  end

  def message
    "PhantomJS requires Mac OS X 10.6 (Snow Leopard) or newer."
  end
end

class Phantomjs < Formula
  homepage 'http://www.phantomjs.org/'
  url "https://github.com/downloads/potatosalad/homebrew/phantomjs-1.6-git.tar.bz2"
  sha1 '28978e6bd2d8a0d2323a4e4c8c4fc2179992e8d0'

  depends_on SnowLeopardOrNewer.new

  # phantomjs wrapper script to hide dock icon
  # See http://code.google.com/p/phantomjs/issues/detail?id=281
  def script; <<-EOS.undent
    #!/bin/sh
    exec "#{libexec}/phantomjs" "$@"
    EOS
  end

  def install
    libexec.install 'bin/phantomjs', 'bin/Info.plist'
    (bin+'phantomjs').write script
  end
end